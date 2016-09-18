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
    var mgr: Alamofire.Manager!
    override func viewDidLoad() {
        super.viewDidLoad()
        mgr = configureManager()
        KeyUITextField.delegate = self
        IDUITextField.delegate = self
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func displayAlertMassage(Massge : String)
    {
        let alert = UIAlertController(title: "Alert", message: Massge, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated:true, completion: nil)
    }
    func makePostRequest(){
        print(uid! + uwd!)
        //var userIDStored : String?
        //var userPWStored : String?
        let refreshedToken = FIRInstanceID.instanceID().token()!
        var parameters:[String: String] = Dictionary()
        /*
        //print("Empty decide for NSUserDefault : \((userIDStored?.isEmpty)) + \(userPWStored?.isEmpty)")
        
        print("Empty decide : \((userIDStored?.isEmpty)) + \(userPWStored?.isEmpty)")
        
        
        if(userIDStored?.isEmpty == false && userPWStored?.isEmpty == false)// 저장된게 있다면
        {
            userIDStored = ShareData.sharedInstance.storedID!
            userPWStored = ShareData.sharedInstance.storedPW!
        }
        
        else // 저장된게 없다면
        {
            if(uid?.isEmpty == false && uwd?.isEmpty == false)
            {
                userIDStored = uid!
                userPWStored = uwd!
                print("uid & uwd does exist ")
            }
            else
            {
                userIDStored = ShareData.sharedInstance.storedID!
                userPWStored = ShareData.sharedInstance.storedPW!
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("login View") as! LoginViewController
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                
            }
            
        }

        
        if(IDUITextField.text! != userIDStored)
        {
            print("idtextfield : \(IDUITextField.text!)")
            displayAlertMassage("ID is Wrong")
        }
        else
        {
            if(KeyUITextField.text! != userPWStored)
            {
                displayAlertMassage("PW is Wrong")
            }
            else
            {
                
            }
        }
    */
        if (refreshedToken.isEmpty){
            parameters = ["user_id" : IDUITextField.text!,"password" : KeyUITextField.text!]
            print("refreshetoken non exist ")
            
        }
        else{
            parameters = ["user_id" : IDUITextField.text!,"password" : KeyUITextField.text!, "token" : refreshedToken]
            print("refreshetoken exist \(refreshedToken)")
        }

        mgr.request(.POST, string_url+"/req_login", parameters: parameters).responseJSON { (response) in
            print("response for req_login : \(response)")
            let responseUserKey = (response.result.value!["user_key"])!
            ShareData.sharedInstance.storedKey = responseUserKey as? String
            self.messageDecision = (response.result.value!["message"] as? String)!
            NSUserDefaults.standardUserDefaults().setObject(responseUserKey, forKey: "New_user_key")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            print(cookies.cookiesForURL(NSURL(string: string_url+"/req_login")!))
            
            if(self.messageDecision != "Success")
            {
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("login View") as! LoginViewController
                print("message non success")
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            }
            else
            {
                let vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("tab bar") as! Tabbar
                print("messae sucess!!!")
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(vc2, animated: true, completion: nil)
                }
            }
        }
    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login(sender: UIButton) {
        
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("NewID")
        print(userId)
        print("Stored user id : " + uid!)
        print("Stored user pwd : " + uwd!)
        if(userId == nil)
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else
        {
            
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
