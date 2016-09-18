//
//  ProtectedViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 9. 17..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import Firebase

class ProtectedViewController: UIViewController {
    var mgr: Alamofire.Manager!

    func makePostRequest(){
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        mgr = Alamofire.Manager(configuration: configuration)

        let refreshedToken = FIRInstanceID.instanceID().token()!
        var parameters:[String: String] = Dictionary()
        if (refreshedToken.isEmpty){
            parameters = ["user_id" : uid!,"password" : uwd!]
            print("refreshetoken non exist ")
            
        }
        else{
            parameters = ["user_id" : uid!,"password" : uwd!, "token" : refreshedToken]
            print("refreshetoken exist \(refreshedToken)")
        }
        mgr.request(.POST, string_url+"/req_login", parameters: parameters).responseJSON { (response) in
            print("response for req_login : \(response)")
            let responseUserKey = (response.result.value!["user_key"])!
            ShareData.sharedInstance.storedKey = responseUserKey as? String
            NSUserDefaults.standardUserDefaults().setObject(responseUserKey, forKey: "New_user_key")
            NSUserDefaults.standardUserDefaults().synchronize()
            let vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("tab bar") as! Tabbar
            print("Go to Tab bar!!!")
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(vc2, animated: true, completion: nil)
            }
        }
 
    }

    
    override func viewDidLoad() {
        
        print("Stored user id : \(uid!) + Sotred user pwd : \(uwd!)")
        
        if(uid == nil && uwd == nil) // 전에 로그인 한 기록이 없는 경우
        {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("login View") as! LoginViewController
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
        else
        {
            ShareData.sharedInstance.storedID = uid
            ShareData.sharedInstance.storedPW = uwd
            makePostRequest()
            
            

        }
    }
}
