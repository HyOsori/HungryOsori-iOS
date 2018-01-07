//
//  LoginController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 12..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import ObjectMapper
import FBSDKLoginKit
import IQKeyboardManagerSwift

class LoginController: UIViewController {

    var titleLabel: UILabel!
    
    var idLabel: UILabel!
    
    var pwLabel: UILabel!
    
    var idTextField: UITextField!
    
    var pwTextField: UITextField!
    
    var loginBtn: UIButton!
    
    var registerBtn: UIButton!
    
    var orLabel: UILabel!
    
    var findPWBtn: UIButton!
    
    var fbLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        viewConfig()
        IQKeyboardManager.sharedManager().enable = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginController {
    func viewConfig() {
        titleLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/6, y: self.view.frame.height - self.view.frame.height*3/4, width: self.view.frame.width/3, height: self.view.frame.height/16))
        titleLabel.text = "Login View"
        titleLabel.textAlignment = .center
        
        idLabel = UILabel(frame: CGRect(x: self.view.frame.width/16, y: titleLabel.frame.origin.y + titleLabel.frame.height + self.view.frame.height/16, width: self.view.frame.width/8, height: self.view.frame.height/16))
        idLabel.text = "ID"
        idLabel.textColor = .blue
        idLabel.textAlignment = .center
        
        idTextField = UITextField(frame: CGRect(x: idLabel.frame.origin.x + idLabel.frame.width + 10, y: idLabel.frame.origin.y, width: self.view.frame.width*2/3, height: idLabel.frame.height))
        idTextField.borderStyle = .roundedRect
        idTextField.placeholder = "E-mail"
        
        pwLabel = UILabel(frame: CGRect(x: idLabel.frame.origin.x, y: idLabel.frame.origin.y + idLabel.frame.height + 10, width: idLabel.frame.width, height: idLabel.frame.height))
        pwLabel.text = "PW"
        pwLabel.textColor = .blue
        pwLabel.textAlignment = .center
        
        pwTextField = UITextField(frame: CGRect(x: pwLabel.frame.origin.x + pwLabel.frame.width + 10, y: pwLabel.frame.origin.y, width: idTextField.frame.width, height: idLabel.frame.height))
        pwTextField.borderStyle = .roundedRect
        pwTextField.placeholder = "Password"
        pwTextField.isSecureTextEntry = true
        
        loginBtn = UIButton(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/4 - 10, y: pwTextField.frame.origin.y + pwTextField.frame.height + 10, width: self.view.frame.width/4, height: self.view.frame.height/20))
        loginBtn.setTitle("Log in", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = .blue
        loginBtn.addTarget(self, action: #selector(onClickLoginBtn(_:)), for: .touchUpInside)
        
        registerBtn = UIButton(frame: CGRect(x: self.view.frame.width/2 + 10, y: loginBtn.frame.origin.y, width: self.view.frame.width/4, height: loginBtn.frame.height))
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.backgroundColor = .orange
        registerBtn.addTarget(self, action: #selector(onClickRegisterBtn(_:)), for: .touchUpInside)
        
        orLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 25, y: registerBtn.frame.origin.y + registerBtn.frame.height + 5, width: 50, height: idLabel.frame.height))
        orLabel.text = "OR"
        orLabel.textAlignment = .center
        
        findPWBtn = UIButton(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/8, y: orLabel.frame.origin.y + orLabel.frame.height + 5, width: self.view.frame.width/4, height: loginBtn.frame.height))
        findPWBtn.setTitleColor(.white, for: .normal)
        findPWBtn.setTitle("비밀번호 찾기", for: .normal)
        findPWBtn.backgroundColor = .red
        findPWBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        findPWBtn.addTarget(self, action: #selector(onClickfindPWBtn(_:)), for: .touchUpInside)
        
        fbLoginBtn = UIButton(frame: CGRect(x: 0, y: findPWBtn.frame.origin.y + findPWBtn.frame.height + 5, width: self.view.frame.width/4, height: loginBtn.frame.height))
        fbLoginBtn.backgroundColor = UIColor(netHex: 0x295798)
        fbLoginBtn.center.x = UIScreen.main.bounds.width/2
        
        fbLoginBtn.setTitle("facebook", for: .normal)
        fbLoginBtn.setTitleColor(.white, for: .normal)
        fbLoginBtn.addTarget(self, action: #selector(onClickFBButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(pwLabel)
        self.view.addSubview(pwTextField)
        self.view.addSubview(loginBtn)
        self.view.addSubview(registerBtn)
        self.view.addSubview(orLabel)
        self.view.addSubview(findPWBtn)
        self.view.addSubview(fbLoginBtn)
    }
    
    @objc func onClickFBButton(_ sender: UIButton) {
        let manager = FBSDKLoginManager()
        manager.loginBehavior = .native
        manager.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: self) { (result, err) in
            if err != nil {
                print("[FB로그인] handleCustomFBLogin실패: \(String(describing: err))")
                return
            } else {
                print("[FB로그인] handleCustomFBLogin성공")
            }
            print("result \(result)")
            self.fbLogin()
        }
    }
    
    func fbLogin() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {
            return }
        print("accessTokenString \(accessTokenString)")
        
        if accessToken != nil {
            FBSDKGraphRequest(graphPath: "me?fields=email,id,name,friends", parameters: nil).start { (connection, result, err) in
                
                if err != nil {
                    print("FBLogin Error: \(String(describing: err))")
                    return
                }
                print(result!)
                let facebook_info = result as! [String : AnyObject]
                if(facebook_info["email"] != nil) {
                    let email = facebook_info["email"] as! String
                    let name = facebook_info["name"]! as! String
                    let refreshedToken = InstanceID.instanceID().token()!
                    Alamofire.request(serverURL + "/social_sign/", method: .post, parameters: ["email": email, "name": name, "sign_up_type": "facebook", "push_token": refreshedToken], encoding: JSONEncoding.default).responseJSON(completionHandler: { (fbSignUpRes) in
                        print("fbSignUpRes.result \(fbSignUpRes.result)")
                        switch fbSignUpRes.result {
                        case.success(let data):
                            print("Data \(data)")
                            let server_data = data as! [String: Any]
                            let errorCode = server_data["ErrorCode"] as! Int
                            switch errorCode {
                            case 0:
                                let token = server_data["token"] as? String
                                if(token != nil) {
                                    Alamofire.request(serverURL + "/crawlers/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : "Token " + token!]).responseJSON { (getEntireRes) in
                                        print("getEntireRes \(getEntireRes.result)")
                                        switch getEntireRes.result {
                                        case.success(let data):
                                            print("Data \(data)")
                                            let serverResult = data as! [String: Any]
                                            let getCrawlerErrorCode = serverResult["ErrorCode"] as! Int
                                            print("serverResult \(serverResult)")
                                            switch getCrawlerErrorCode {
                                            case 0:
                                                let serverCrawlerList = Mapper<CrawlerList>().mapArray(JSONArray: serverResult["crawlers"] as! [[String : Any]])
                                                let mainTabbar = CrawlerTabBarController()
                                                let entireController = RootNaviController(rootViewController: EntireCrawlerController(crawlerList: serverCrawlerList, token: token!))
                                                let subscribedController = RootNaviController(rootViewController: SubscribedCrawlerController(token: token!,entireCrawlerList: serverCrawlerList))
                                                mainTabbar.viewControllers = [entireController, subscribedController]
                                                self.present(mainTabbar, animated: false, completion: nil)
                                            case -100:
                                                print("크롤러가 한개도 없음...!")
                                            default:
                                                print("서버 에러")
                                            }
                                        case.failure(let err):
                                            print("Err \(err)")
                                        }
                                    }
                                }
                            case -1:
                                self.showLoginErrorAlert(message: "이메일 혹은 비밀번호가 비어있습니다 확인해주세요")
                            case -100:
                                self.showLoginErrorAlert(message: "존재하지 않는 아이디입니다. 확인해주세요")
                            case -200:
                                self.showLoginErrorAlert(message: "비밀번호가 틀렸습니다. 확인해주세요")
                            case -300:
                                self.showLoginErrorAlert(message: "회원가입하신 이메일을 확인하여 인증해주세요")
                            default: //알수없는 오류.
                                self.showLoginErrorAlert(message: "이메일 혹은 비밀번호가 비어있습니다 확인해주세요")
                            }
                        case.failure(let err):
                            print("Errr \(err)")
                        }
                    })
                }
                
            }
        }
    }
    
    
    func onClickRegisterBtn(_ sender: UIButton) {
        self.present(RegisterController(), animated: false, completion: nil)
    }
    
    func onClickfindPWBtn(_ sender: UIButton) {
        self.present(FindPasswordController(), animated: false, completion: nil)
    }
    
    func onClickLoginBtn(_ sender: UIButton) {
        let refreshedToken = InstanceID.instanceID().token()!
        Alamofire.request(serverURL + "/signin/", method: .post, parameters: ["email": idTextField.text!, "password": pwTextField.text!, "push_token": refreshedToken]).responseJSON { (signinRes) in
            print("signinRes.result \(signinRes.result)")
            switch signinRes.result {
            case.success(let data):
                print("succes \(data)")
                let server_data = data as! [String: Any]
                let errorCode = server_data["ErrorCode"] as! Int
                switch errorCode {
                case 0:
                    let token = server_data["token"] as? String
                    print("token \(token)")
                    if(token != nil) {
                        Alamofire.request(serverURL + "/crawlers/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : "Token " + token!]).responseJSON { (getEntireRes) in
                            print("getEntireRes \(getEntireRes.result)")
                            switch getEntireRes.result {
                            case.success(let data):
                                let serverResult = data as! [String: Any]
                                let getCrawlerErrorCode = serverResult["ErrorCode"] as! Int
                                switch getCrawlerErrorCode {
                                case 0:
                                    let serverCrawlerList = Mapper<CrawlerList>().mapArray(JSONArray: serverResult["crawlers"] as! [[String : Any]])
                                    let mainTabbar = CrawlerTabBarController()
                                    let entireController = RootNaviController(rootViewController: EntireCrawlerController(crawlerList: serverCrawlerList, token: token!))
                                    let subscribedController = RootNaviController(rootViewController: SubscribedCrawlerController(token: token!,entireCrawlerList: serverCrawlerList))
                                    mainTabbar.viewControllers = [entireController, subscribedController]
                                    self.navigationController?.pushViewController(mainTabbar, animated: false)
                                case -100:
                                    print("크롤러가 한개도 없음...!")
                                default:
                                    print("서버 에러")
                                }
                            case.failure(let err):
                                print("Err \(err)")
                            }
                        }
                    }
                case -1:
                    self.showLoginErrorAlert(message: "이메일 혹은 비밀번호가 비어있습니다 확인해주세요")
                case -100:
                    self.showLoginErrorAlert(message: "존재하지 않는 아이디입니다. 확인해주세요")
                case -200:
                    self.showLoginErrorAlert(message: "비밀번호가 틀렸습니다. 확인해주세요")
                case -300:
                    self.showLoginErrorAlert(message: "회원가입하신 이메일을 확인하여 인증해주세요")
                default: //알수없는 오류.
                    self.showLoginErrorAlert(message: "이메일 혹은 비밀번호가 비어있습니다 확인해주세요")
                }
            case.failure(let err):
                print("err \(err)")
            }
        }
    }
    
    func showLoginErrorAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("로그인 실패!")
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension LoginController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("[FB로그인]로그인성공!!!")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("[FB로그인]로그아웃loginBtnDidLogout")
    }
    
    
}
