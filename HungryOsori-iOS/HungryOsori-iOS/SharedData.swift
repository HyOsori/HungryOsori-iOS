//
//  SharedData.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 9..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation

class ShareData {
    static let sharedInstance = ShareData()
    
    var entireList = [Crawler]()
    var unsubscriptionList = [Crawler]()
    var unsubscription_count : [Bool] = []
    var storedID : String?
    var storedPW : String?
    var storedKey : String?
    var storedName : String?
    
}
