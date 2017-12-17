//
//  RegisterController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 13..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import IQKeyboardManagerSwift

class RegisterController: UIViewController {

    var registerPageLabel: UILabel!
    
    var userNameLabel: UILabel!
    
    var userNameTextField: UITextField!
    
    var idLabel: UILabel!
    
    var idTextField: UITextField!
    
    var pwLabel: UILabel!
    
    var pwTextField: UITextField!
    
    var rePWLabel: UILabel!
    
    var rePWTextField: UITextField!
    
    var loginBtn: UIButton!
    
    var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .white
        registerViewConfig()
        IQKeyboardManager.sharedManager().enable = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterController {
    func registerViewConfig() {
        registerPageLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/6, y: self.view.frame.height - self.view.frame.height*4/5, width: self.view.frame.width/3, height: self.view.frame.height/16))
        registerPageLabel.text = "Register Page"
        
        userNameLabel = UILabel(frame: CGRect(x: self.view.frame.width/16, y: registerPageLabel.frame.origin.y + registerPageLabel.frame.height, width: self.view.frame.width - self.view.frame.width/8, height: registerPageLabel.frame.height))
        userNameLabel.text = "User name :"
        
        userNameTextField = UITextField(frame: CGRect(x: userNameLabel.frame.origin.x, y: userNameLabel.frame.origin.y + userNameLabel.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        userNameTextField.placeholder = "User name"
        userNameTextField.borderStyle = .roundedRect
        
        idLabel = UILabel(frame: CGRect(x: userNameLabel.frame.origin.x, y: userNameTextField.frame.origin.y + userNameTextField.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        idLabel.text = "ID :"
        
        idTextField = UITextField(frame: CGRect(x: userNameLabel.frame.origin.x, y: idLabel.frame.origin.y + idLabel.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        
        pwLabel = UILabel(frame: CGRect(x: userNameLabel.frame.origin.x, y: idTextField.frame.origin.y + idTextField.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        pwLabel.text = "Password :"
        
        pwTextField = UITextField(frame: CGRect(x: userNameLabel.frame.origin.x, y: pwLabel.frame.origin.y + pwLabel.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        pwTextField.placeholder = "Password"
        
        pwTextField.borderStyle = .roundedRect
        pwTextField.isSecureTextEntry = true
        
        rePWLabel = UILabel(frame: CGRect(x: userNameLabel.frame.origin.x, y: pwTextField.frame.origin.y + pwTextField.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        rePWLabel.text = "Repeat Password :"
        
        rePWTextField = UITextField(frame: CGRect(x: userNameLabel.frame.origin.x, y: rePWLabel.frame.origin.y + rePWLabel.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        rePWTextField.placeholder = "Repeat Password"
        rePWTextField.borderStyle = .roundedRect
        rePWTextField.isSecureTextEntry = true
        
        loginBtn = UIButton(frame: CGRect(x: userNameLabel.frame.origin.x, y: rePWTextField.frame.origin.y + rePWTextField.frame.height, width: userNameLabel.frame.width, height: userNameLabel.frame.height))
        loginBtn.setTitle("I have an account! Let me login", for: .normal)
        loginBtn.titleLabel?.textAlignment = .center
        loginBtn.setTitleColor(.blue, for: .normal)
        loginBtn.addTarget(self, action: #selector(onClickLoginBtn(_:)), for: .touchUpInside)
        
        registerBtn = UIButton(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/8, y: loginBtn.frame.origin.y + loginBtn.frame.height, width: self.view.frame.width/4, height: userNameLabel.frame.height))
        registerBtn.backgroundColor = .blue
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.addTarget(self, action: #selector(onClickRegisterButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(registerPageLabel)
        self.view.addSubview(userNameLabel)
        self.view.addSubview(userNameTextField)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(pwLabel)
        self.view.addSubview(pwTextField)
        self.view.addSubview(rePWLabel)
        self.view.addSubview(rePWTextField)
        self.view.addSubview(loginBtn)
        self.view.addSubview(registerBtn)
        
    }
    
    func onClickRegisterButton(_ sender: UIButton) {
        Alamofire.request(serverURL + "/signup/", method: .post, parameters: ["name": userNameTextField.text!, "email": idTextField.text!, "password": pwTextField.text!, "sign_up_type": "email"], encoding: JSONEncoding.default).responseJSON { (signupRes) in
            print("signupRes \(signupRes.result)")
            switch signupRes.result {
            case.success(let data):
                print("Data \(data)")
                let server_data = data as! [String: Any]
                print("server_data \(server_data)")
            case.failure(let err):
                print("err \(err)")
            }
        }
    }
    
    func onClickLoginBtn(_ sender: UIButton) {
        Alamofire.request(serverURL + "/users/", method: .post, parameters: ["name": userNameTextField.text!, "email": idTextField.text!, "password": pwTextField.text!]).responseJSON { (registerRes) in
            print("registerRes \(registerRes.result)")
            switch registerRes.result {
            case.success(let data):
                print("data \(data)")
                self.dismiss(animated: false, completion: nil)
            case.failure(let err):
                print("err \(err)")
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
