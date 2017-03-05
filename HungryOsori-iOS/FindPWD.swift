//
//  FindPWD.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 9. 18..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class FindPWD: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var UserID: UITextField!
    var mgr: Alamofire.SessionManager!
    var userid : String?
    
    func displayAlertMassage(_ Message : String)
    {
        let alert = UIAlertController(title: "SUCCESS", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated:true, completion: nil)
    }
    
    func makePostRequest(){
        userid = UserID.text
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        mgr = Alamofire.SessionManager(configuration: configuration)
        var parameters:[String: String] = Dictionary()
        
        parameters = ["user_id" : userid!]
        mgr.request(string_url+"/password/",method: .post, parameters: parameters).responseString { (response) in
            print(response.result)
            print("response for find pwd : \(response)")
        self.displayAlertMassage("Check your E-mail")
        }
        
    }
    override func viewDidLoad() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        mgr = Alamofire.SessionManager(configuration: configuration)
    }
    
    @IBAction func Find(_ sender: UIButton) {
        makePostRequest()
    }
    
}
