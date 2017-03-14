//
//  WebViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 3. 5..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        webView.delegate = self
        
        webView.loadRequest(URLRequest(url: URL(string: webURL)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
