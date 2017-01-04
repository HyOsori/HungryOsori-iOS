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
    var mgr: Alamofire.SessionManager!

    func makePostRequest(){
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        mgr = Alamofire.SessionManager(configuration: configuration)

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
        /*
        mgr.request(string_url+"/req_login",method: .post, parameters: parameters).responseJSON { (response) in
    
            switch response.result {
            case .success( _) :
                print(response.request!)  // original URL request
                print(response.response!) // HTTP URL response
                print(response.data!)     // server data
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
            
        
                
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "tab bar") as! Tabbar
            print("Go to Tab bar!!!")
            DispatchQueue.main.async {
                self.present(vc2, animated: true, completion: nil)
            }
        }
 
        }
        */
    }

    
    override func viewDidLoad() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login View") as! LoginViewController
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
 
        if(uid == nil && uwd == nil) // 전에 로그인 한 기록이 없는 경우
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login View") as! LoginViewController
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
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
