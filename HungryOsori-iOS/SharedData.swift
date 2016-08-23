//
//  SharedData.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 9..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation

class ShareData {
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ShareData()
        }
        
        return Static.instance!
    }
    var entireList = [Crawler]()
    
    var unsubscriptionList = [Crawler]()
}