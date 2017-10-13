//
//  LoginController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 12..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewConfig()
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
        
        loginBtn = UIButton(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/4 - 10, y: pwTextField.frame.origin.y + pwTextField.frame.height + 10, width: self.view.frame.width/4, height: self.view.frame.height/20))
        loginBtn.setTitle("Log in", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = .blue
        
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
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(pwLabel)
        self.view.addSubview(pwTextField)
        self.view.addSubview(loginBtn)
        self.view.addSubview(registerBtn)
        self.view.addSubview(orLabel)
        self.view.addSubview(findPWBtn)
    }
    
    func onClickRegisterBtn(_ sender: UIButton) {
        self.present(RegisterController(), animated: false, completion: nil)
    }
}
