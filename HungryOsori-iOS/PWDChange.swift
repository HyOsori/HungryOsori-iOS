//
//  PWDChange.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 9. 18..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PWDChange: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var UserID: UITextField!
    @IBOutlet weak var ExistingPWD: UITextField!
    @IBOutlet weak var NewPWD: UITextField!
    var mgr: Alamofire.SessionManager!
    var userid:String?
    var oldpwd:String?
    var newpwd:String?
    
    func makePostRequest(){
        userid = UserID.text
        oldpwd = ExistingPWD.text
        newpwd = NewPWD.text
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        mgr = Alamofire.SessionManager(configuration: configuration)
        var parameters:[String: String] = Dictionary()
        
        parameters = ["user_id" : userid!,"password" : oldpwd!, "new_password" : newpwd!]
        mgr.request(string_url+"/password/",method: .put, parameters: parameters).responseString { (response) in
            print("response for find pwd : \(response)")
            print("response for find pwd result : \(response.result)")
        }
        
    }
    override func viewDidLoad() {
        
    }
    @IBAction func Save(_ sender: UIButton) {
            makePostRequest()
        
    }
    

}
