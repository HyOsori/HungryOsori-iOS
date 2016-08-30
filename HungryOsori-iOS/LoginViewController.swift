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

class LoginViewController: UIViewController {
    var messageDecision:String?
    //let string_url = "http://192.168.0.35:20003"
    @IBOutlet weak var KeyUITextField: UITextField!
    @IBOutlet weak var IDUITextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func displayAlertMassage(Massge : String)
    {
        let alert = UIAlertController(title: "Alert", message: Massge, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated:true, completion: nil)
    }
    func makePostRequest(){
        let userid_in_req = IDUITextField.text
        let refreshedToken = FIRInstanceID.instanceID().token()!
        var parameters:[String: String] = Dictionary()
        if (refreshedToken.isEmpty){
            parameters = ["user_id" : userid_in_req!, "token" : refreshedToken]
            print("refreshetoken non exist ")
            
        }
        else{
            parameters = ["user_id" : userid_in_req!]
            print("refreshetoken exist \(refreshedToken)")
        }

        Alamofire.request(.POST, string_url+"/req_login", parameters: parameters).responseJSON { (response) in
            let responseUserKey = (response.result.value!["user_key"])!
            self.messageDecision = (response.result.value!["message"] as? String)!
            NSUserDefaults.standardUserDefaults().setObject(responseUserKey, forKey: "New_user_key")
            NSUserDefaults.standardUserDefaults().synchronize()
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
   /*
    func URLEncode(s: String) -> String? {
        return (s as NSString).stringByAddingPercentEncodingWithAllowedCharacters(
            .URLHostAllowedCharacterSet())
    }
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login(sender: UIButton) {
        
        let userId = IDUITextField.text
        let userIDStored = NSUserDefaults.standardUserDefaults().stringForKey("NewID")
        
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
            NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "New_user_id")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }

        makePostRequest()
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedin")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
