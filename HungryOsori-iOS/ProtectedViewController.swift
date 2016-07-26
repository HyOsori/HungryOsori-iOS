//
//  ProtectedViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 25..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class ProtectedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let isUserLoggedin = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedin")
        if (!isUserLoggedin)
        {
            self.performSegueWithIdentifier("login View", sender: self)

        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
