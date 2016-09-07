//
//  GlobalVariable.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 29..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation
import Alamofire

let string_url = "http://192.168.0.35:8080"
//let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
//let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
let userID = ShareData.sharedInstance.storedID!
let userKey = ShareData.sharedInstance.storedKey!
let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
//let cooky = NSHTTPCookie

func configureManager() -> Alamofire.Manager {
    let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
    cfg.HTTPCookieStorage = cookies
    return Alamofire.Manager(configuration: cfg)
}

func validateEmail(candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
}