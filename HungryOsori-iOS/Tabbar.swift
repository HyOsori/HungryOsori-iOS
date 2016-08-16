//
//  Tabbar.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 9..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Foundation


class Tabbar: UITabBarController {
    /*
    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    
    public struct Crawler
    {
        let id:String
        let title:String
        let description:String
        let thumbnailURL:String
        
        init(json:[String:AnyObject])
        {
            self.id = json["crawler_id"] as! String
            self.title = json["title"] as! String
            self.description = json["description"] as! String
            self.thumbnailURL = json["thumbnail_url"] as! String
        }
        
    }
    
    public struct Crawlers
    {
        var crawlers = [String:Crawler]()
        var temp_crawler_list = [Osori]()
        
        init()
        {
            
        }
        
        init(jsonString:String)
        {
            let data: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
            
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if json["error"] as! Int == 0
                {
                    for jsonCrawler in (json["crawlers"] as! [AnyObject])
                    {
                        let newCrawler = Crawler(json:(jsonCrawler as! [String : AnyObject]))
                        crawlers[newCrawler.id] = newCrawler
                        temp_crawler_list.append(Osori(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL))

                        ShareData.sharedInstance.entireList.append(Osori(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description,  image: newCrawler.thumbnailURL))
                            print("Tab bar List : \(newCrawler.title)")
                        }
                        
                    }
                }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
    }

    var crawlers:Crawlers? = Crawlers()
    
    override func viewDidLoad() {
        for i in 0...4
        {
            let temp_id = ShareData.sharedInstance.entireList[i].id
            let temp_title = ShareData.sharedInstance.entireList[i].title
            let temp_des = ShareData.sharedInstance.entireList[i].description
            let temp_image = ShareData.sharedInstance.entireList[i].image
            self.crawlers?.temp_crawler_list.append(Osori(id: temp_id, title: temp_title, description: temp_des, image: temp_image))
        }
        super.viewDidLoad()
    }
    
    func makePostRequest(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_entire_list")!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.crawlers = Crawlers(jsonString: responseString as! String)
        }
        task.resume()
    }
*/

}