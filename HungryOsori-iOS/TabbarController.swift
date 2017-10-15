//
//  TabbarController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 15..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import Foundation
import UIKit

class CrawlerTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbar = self.tabBar
        let tabbarItems = self.tabBar.items
        
        tabbar.barTintColor = .white
        tabbar.isTranslucent = false
        
        
//        let itemUnselected : [UIImage] = [UIImage(named: "home")!, UIImage(named: "channel")!, UIImage(named: "map")!, UIImage(named: "notice")!, UIImage(named: "profile_unselect")!]
//        
//        let itemSelected : [UIImage] = [UIImage(named: "home_select")!, UIImage(named: "channel_select")!, UIImage(named: "map_select")!, UIImage(named: "notice_select")!, UIImage(named: "profile_select")!]
//        
//        let itemTitle = ["HOME","CHANNEL","MAP","NOTICE","PROFILE"]
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : mainColor], for: .selected)
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : mainTextColor], for: UIControlState.normal)
        
        
//        for (i, item) in (tabbarItems?.enumerated())! {
//            
//            let img = resizeImage(image:itemUnselected[i], targetSize: CGSize(width: 26, height: 26))
//            let selected_img = resizeImage(image: itemSelected[i], targetSize: CGSize(width: 26, height: 26))
//            item.image = img.withRenderingMode(.alwaysOriginal)
//            item.selectedImage = selected_img.withRenderingMode(.alwaysOriginal)
//            item.title = itemTitle[i]
//        }
//        
//        if let v = tabBar.items {
//            for item in v {
//                if nil == item.title {
//                    let inset: CGFloat = 7
//                    item.imageInsets = UIEdgeInsetsMake(inset, 0, -inset, 0)
//                } else {
//                    let inset: CGFloat = 0.5
//                    item.titlePositionAdjustment.vertical = inset
//                }
//            }
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
