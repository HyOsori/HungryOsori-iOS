//
//  UserInformation.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 9. 18..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation
import UIKit

class UserInformation: UIViewController {
    @IBOutlet weak var UserID: UILabel!
    @IBOutlet weak var UserPWD: UILabel!
    @IBOutlet weak var UserName: UILabel!
    
    override func viewDidLoad() {
        UserID.text = ShareData.sharedInstance.storedID
        UserPWD.text = ShareData.sharedInstance.storedPW
        UserName.text = ShareData.sharedInstance.storedName
        
        print("User Information : \(UserName.text) + \(UserID.text) + \(UserPWD.text)")
    }

    
    
}
