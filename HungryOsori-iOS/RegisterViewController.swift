//
//  RegisterViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 21..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var NewIdUITextField: UITextField!
    @IBOutlet weak var NewPassword: UITextField!
    
    var mgr: Alamofire.Manager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makePostRequest(){
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        mgr = Alamofire.Manager(configuration: configuration)
        
        let newid = NewIdUITextField.text
        let newpw = NewPassword.text
        mgr.request(.POST,  string_url+"/req_signup", parameters: ["user_id" : newid!,"password" : newpw!]).responseJSON { (response) in
            print("Response Json  !!!!! : \(response)")
            //print(cookies.cookiesForURL(NSURL(string: string_url+"/req_signup")!))
            
            print(NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: string_url+"/req_signup")!))
        }
    }
    
    
    func displayAlertMassage(Massge : String)
    {
        let alert = UIAlertController(title: "Alert", message: Massge, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
    
        self.presentViewController(alert, animated:true, completion: nil)
    }
    
    @IBAction func RegisterUIButton(sender: AnyObject) {
        let NewIdUIText = NewIdUITextField.text
        let NewPWUIText = NewPassword.text
        
        ShareData.sharedInstance.storedID = NewIdUIText
        ShareData.sharedInstance.storedPW = NewPWUIText
        
        print("shareData info : \(ShareData.sharedInstance.storedID) + \(ShareData.sharedInstance.storedPW)")
        
        //Check For whether empty or not
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
        
        //Storing Data
        NSUserDefaults.standardUserDefaults().setObject(NewIdUIText, forKey: "NewID")
        NSUserDefaults.standardUserDefaults().setObject(NewPWUIText, forKey: "NewPW")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let alert = UIAlertController(title: "alert", message: "Register Successful", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            ACTION in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated:true, completion: nil)

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
