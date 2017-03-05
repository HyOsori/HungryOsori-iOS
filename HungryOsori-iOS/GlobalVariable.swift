//
//  GlobalVariable.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 29..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation
import Alamofire


let string_url = "http://52.78.113.6:8000"
var userID :String?//= UserDefaults.standard.string(forKey: "New_user_id")
var userKey :String?//UserDefaults.standard.string(forKey: "New_user_key")
var uid : String?
var uwd : String?
var webURL = ""


let cookies = HTTPCookieStorage.shared

func configureManager() -> Alamofire.SessionManager {
    let cfg = URLSessionConfiguration.default
    cfg.httpCookieStorage = cookies
    return Alamofire.SessionManager(configuration: cfg)
}

func validateEmail(_ candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
}
