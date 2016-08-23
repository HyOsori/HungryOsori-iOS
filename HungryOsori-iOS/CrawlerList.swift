//
//  CrawlerList.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 23..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation

public struct Crawlers
{
    var crawlers = [String:Crawler]()
    var crawler_list = [Osori]()
    
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
                    crawler_list.append(Osori(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL))
                    
                }
            }
        }
        catch
        {
            print("error serializing JSON: \(error)")
        }
    }
}
