//
//  LoginViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 21..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var messageDecision:String?

    @IBOutlet weak var KeyUITextField: UITextField!
    @IBOutlet weak var IDUITextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        makePostRequest()
        
        
        

        // Do any additional setup after loading the view.
    }
    func displayAlertMassage(Massge : String)
    {
        var alert = UIAlertController(title: "Alert", message: Massge, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated:true, completion: nil)
    }
    
    func makePostRequest(){

        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_login")!)

        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")

        
        print("user id! \(IDUITextField.text!)")
        
        let postString:String = "user_id=\(IDUITextField.text!)"
        
        
        print("postString! : \(postString)")
        
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)

        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString!)")
            
            do {
                let JsonData =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = JsonData {
                    
                    // Now we can access value of First Name by its key
                    //messageDecision = parseJSON["message"] as? String
                    self.messageDecision = (parseJSON["message"] as? String)!
                    
                    print("message: \(self.messageDecision)")
                }
            } catch {
                print(error)
            }
        }
        task.resume()

        
        
    }
    
    func URLEncode(s: String) -> String? {
        return (s as NSString).stringByAddingPercentEncodingWithAllowedCharacters(
            .URLHostAllowedCharacterSet())
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login(sender: UIButton) {
        let userId = IDUITextField.text
        let userKey = KeyUITextField.text
        
        let userIDStored = NSUserDefaults.standardUserDefaults().stringForKey("NewID")
        
        if (userId == userIDStored)
        {
            //Login successsful
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedin")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
            
        else
        {
            displayAlertMassage("Put your ID that you want to use")
            return
            
        }
        
        if(userId == nil)
        {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username]"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else
        {
            
            print("message!!! : \(messageDecision!)")
            print("selfmessage!! : \(self.messageDecision!)")
            if(messageDecision != "Success")
            {
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("login View") as! LoginViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            else
            {
                let vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("Second") as! SecondViewController
                self.presentViewController(vc2, animated: true, completion: nil)
            }
        }
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