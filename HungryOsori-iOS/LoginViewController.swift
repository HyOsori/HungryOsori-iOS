//
//  LoginViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 21..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    var messageDecision:String?
    @IBOutlet weak var KeyUITextField: UITextField!
    @IBOutlet weak var IDUITextField: UITextField!
    var mgr: Alamofire.SessionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        mgr = configureManager()
        
        KeyUITextField.delegate = self
        IDUITextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func displayAlertMassage(_ Massage : String)
    {
        let alert = UIAlertController(title: "Sign Up Failed !", message: Massage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated:true, completion: nil)
    }
    func makePostRequest(){
        let refreshedToken = InstanceID.instanceID().token()!
        var parameters:[String: String] = Dictionary()
        if (refreshedToken.isEmpty){
            parameters = ["user_id" : IDUITextField.text!,"password" : KeyUITextField.text!]
            print("refreshetoken non exist ")
            
        }
        else{
            parameters = ["user_id" : IDUITextField.text!,"password" : KeyUITextField.text!, "push_token" : refreshedToken]
            print("refreshetoken exist \(refreshedToken)")
        }
        
        
        
        
        mgr.request(string_url+"/user/",method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            print(response.data!)     // server data
            print("result ????? : \(response.result)")   // result of response serialization
            
            switch(response.result) {
            case .success(_):
                    if let JSON = response.result.value as! [String:AnyObject]!{
                        print("is This JASON : \(JSON)")
                        
                        let responseUserKey = JSON["user_key"]!
                        ShareData.sharedInstance.storedKey = responseUserKey as? String
                        UserDefaults.standard.set(responseUserKey, forKey: "New_user_key")
                        UserDefaults.standard.synchronize()
                    }
                    
                    print("test response \(response.result.value)")
                    let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "tab bar") as! Tabbar
                    print("messae sucess!!!")
                    DispatchQueue.main.async {
                        self.present(vc2, animated: true, completion: nil)
                    }
                break
                
            case .failure(_):
                print("test response failure : \(response.result.error)")
                let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "login View") as! LoginViewController
                print("messae sucess!!!")
                DispatchQueue.main.async {
                    self.present(vc2, animated: true, completion: nil)
                }
                break
                
            }
        }
       
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login(_ sender: UIButton) {
        userID = IDUITextField.text!
        print("userID : \(userID)")
        if(userID == nil)
        {
            self.displayAlertMassage("Please enter User name!")
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username!"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }

        makePostRequest()
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
