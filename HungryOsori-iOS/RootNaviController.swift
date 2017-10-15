//
//  RootNaviController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 15..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit

class RootNaviController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = navigationBar
        let navItem = navigationItem
        
        self.view.backgroundColor = .white
        
//        UINavigationBar.appearance().tintColor = UIColor(netHex: 0x5b3f36)
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navBar.isTranslucent = false
        navItem.backBarButtonItem?.title = ""
//        navBar.barTintColor = UIColor(netHex: 0x5b3f36)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

