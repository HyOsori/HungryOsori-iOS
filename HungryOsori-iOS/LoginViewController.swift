//
//  LoginViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 21..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var KeyUITextField: UITextField!
    @IBOutlet weak var IDUITextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makePostRequest()
        
        

        // Do any additional setup after loading the view.
    }
    
    func makePostRequest(){
        //       let urlPath: String = "192.168.0.89"
        
        //       let myURL:NSURL = NSURL(string: urlPath)!
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_login")!)
        //       let request = NSMutableURLRequest(URL: myURL)
        request.HTTPMethod = "POST"
        //let json = ["result":"0","message":"success","crawlers":["crawler_id":"string","title":"string","Descrption":"string","item_URL":"URL"]]
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print("success for login view! \(httpResponse.statusCode)")
            }
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            // let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            // print("responseString = \(responseString)")
            
            // Convert server json response to NSDictionary
            
            
            do {
                if let JsontoDic = try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary {
                    
                    //                if let dictionary = JsontoDic as? [String : AnyObject]
                    //               {
                    //                  self.readJSONObject(dictionary)
                    //            }
                    
                    // Get value by key
                    let firstNameValue = JsontoDic["user_key"] as? String
                    //let Crawlers = JsontoDic["crawlers.sdhfi3"] as? [[String: AnyObject]]
             //       print(Crawlers)
                    print(firstNameValue)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login(sender: UIButton) {
        let userId = IDUITextField.text
        let userKey = KeyUITextField.text
        
        if(userId == nil)
        {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username]"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        if(userId != nil)
        {
            print("You have RealID = \(userId!)")
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
