//
//  RegisterViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 21..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var NewIdUITextField: UITextField!
    @IBOutlet weak var NewPassword: UITextField!
    @IBOutlet weak var UserName: UITextField!
    var mgr: Alamofire.SessionManager!
    @IBOutlet weak var RepeatPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NewIdUITextField.delegate = self
        NewPassword.delegate = self
        UserName.delegate = self
        RepeatPassword.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func makePostRequest(){
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        mgr = Alamofire.SessionManager(configuration: configuration)
        
        let newid = NewIdUITextField.text
        let newpw = NewPassword.text
        let newusername = UserName.text
        let repeatPW = RepeatPassword.text
        ShareData.sharedInstance.storedName = newusername
        
        if(newpw != repeatPW)
        {
            displayAlertMassage("비밀번호 불일치")
        }
        
        mgr.request(string_url+"/users/",method: .post, parameters: ["user_id" : newid!,"password" : newpw!,"name" : newusername!]).responseJSON { (response) in
            switch response.result {
            case .success( _) :
                print(response.result)   // result of response serialization
                if let JSON = response.result.value as! [String:AnyObject]!{
                    //let message = JSON["user_key"]
                    let responseUserKey = JSON["user_key"]!
                    ShareData.sharedInstance.storedKey = responseUserKey as? String
                    //self.messageDecision = (response.result.value!["ErrorCode"] as? String)!
                    UserDefaults.standard.set(responseUserKey, forKey: "New_user_key")
                    UserDefaults.standard.synchronize()
                }
            case .failure( _) :
                print("error for encoding!!")
            }
        }
 
        
    }
    
    
    func displayAlertMassage(_ Massge : String)
    {
        let alert = UIAlertController(title: "Alert", message: Massge, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
    
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func RegisterUIButton(_ sender: AnyObject) {
        let NewIdUIText = NewIdUITextField.text
        let NewPWUIText = NewPassword.text
        
        ShareData.sharedInstance.storedID = NewIdUIText
        ShareData.sharedInstance.storedPW = NewPWUIText
        
        //print("shareData info : \(ShareData.sharedInstance.storedID) + \(ShareData.sharedInstance.storedPW)")
        
        if((NewIdUIText?.isEmpty) == nil)
        {
            displayAlertMassage("Put your ID that you want to use")
            return
        }
        else
        {
            if(validateEmail(NewIdUIText!))
            {
                print("email valid success!!!!! \(validateEmail(NewIdUIText!))")
            }
            else{
                displayAlertMassage("Invalid email")
            }
        }
        makePostRequest()
        
        UserDefaults.standard.set(NewIdUIText, forKey: "NewID")
        UserDefaults.standard.set(NewPWUIText, forKey: "NewPW")
        UserDefaults.standard.synchronize()
        
        let alert = UIAlertController(title: "alert", message: "Register Successful", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            ACTION in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated:true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
