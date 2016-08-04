//
//  SecondViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet
    var tableview2:UITableView!
    
    
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
        var osori4 = [Osori]()
        
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
                        //print(newCrawler.title)
                        //print(newCrawler.description)
                        //print(newCrawler.thumbnailURL)
                        osori4.append(Osori(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL))
                        NSUserDefaults.standardUserDefaults().setObject(newCrawler.id, forKey: "Subscribe_id")
                        NSUserDefaults.standardUserDefaults().synchronize()
                    
                    }
                    
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
    }
    
    var crawlers:Crawlers?

    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var Crawler:String?
    var imageURL:UIImageView?
    var realimage:UIImage?
    var osori = [Osori]()
    var osori2 = [Osori]()
    var count:Int?
    var selected:String?
    var subarray = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if((userID != nil) && (userKey != nil))
        {
            makePostRequest()
        }
        
    }
    
    func makePostRequest(){
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_entire_list")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        
        
        
        //print("user id! \(userID!)")
        //print("user key! \(userKey!)")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)"
        
        
        //print("postString! : \(postString)")
        
        
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
            self.count = (self.crawlers?.osori4.count)!
            self.tableview2.reloadData()
        }
        task.resume()
        
        
        
    }
    func makePostRequestScrcibe(){
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_subscribe_crawler")!)
        let subid = NSUserDefaults.standardUserDefaults().stringForKey("Subscribe_id")
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        
        
        
        //print("subscribe user id! \(userID!)")
        //print("subscribe user key! \(userKey!)")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)&crawler_id=\(subid!)"
        
        
        print("subscribe_postString! : \(postString)!")
        
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString2 = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Subscribe_responseString!! \(responseString2)")
            
            //self.crawlers = Crawlers(jsonString: responseString as! String)
            //self.count = (self.crawlers?.osori4.count)!
            //self.tableview2.reloadData()
        }
        task2.resume()
        
        
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (count == nil)
        {
            return 0
        }
        else{
            return count!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2 = tableview2.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! MyTableViewCell
        
        print("indexpathhhhhhhh:\(indexPath.row)")
        let cc = self.crawlers!.osori4[indexPath.row]
    
        cell2.title.text = cc.title
        cell2.des.text = cc.description
        
        
        
        
        let unwrapped: String = cc.image
        let url = NSURL(string : unwrapped)!

        if let data = NSData(contentsOfURL: url)
        {
            if let realimage = UIImage(data: data)
                {
                    cell2.imageurlresult.image = realimage
                    if(cell2.imageurlresult == nil)
                    {
                        print("nillllll")
                    }
                }
                
                   
        }
        cell2.subscribeButton.tag = indexPath.row
        //cell2.subscribeButton.addTarget(self, action: #selector(SecondViewController.makePostRequestScrcibe), forControlEvents: UIControlEvents.TouchUpInside)
        /*for i in 0 ..< 4 {
            cell2.subscribeButton.tag = indexPath.row
            cell2.subscribeButton.setValue(self.crawlers?.osori4[indexPath.row].id, forKey: "subi")
            if let employed : AnyObject = cell2.subscribeButton.valueForKey("subi") {
                print("\(employed)) is not available!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            }
        }
    */
        
    
        return cell2
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selected = self.crawlers!.osori4[indexPath.row].id
        subarray.append(selected!)
        subarray.append((self.crawlers?.osori4[indexPath.row].title)!)
        subarray.append((self.crawlers?.osori4[indexPath.row].description)!)
        subarray.append((self.crawlers?.osori4[indexPath.row].image)!)
        
        NSUserDefaults.standardUserDefaults().objectForKey("Subscribe")
        NSUserDefaults.standardUserDefaults().setObject(selected, forKey: "Subscribe_id")
        NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[indexPath.row].title, forKey: "Subscribe_title")
        NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[indexPath.row].description, forKey: "Subscribe_des")
        NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[indexPath.row].image, forKey: "Subscribe_image")
        NSUserDefaults.standardUserDefaults().synchronize()
        print("subscribeid!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\(selected)")
    }
    
    @IBAction func subscribebutton(sender: UIButton) {
        makePostRequestScrcibe()
        switch sender.tag {
        case 0:
                self.crawlers?.osori4[0].id
                
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[0].id, forKey: "Subscribe_id")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[0].title, forKey: "Subscribe_title")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[0].description, forKey: "Subscribe_des")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[0].image, forKey: "Subscribe_image")
                NSUserDefaults.standardUserDefaults().synchronize()
                            print("subscribeid!!\((self.crawlers?.osori4[0].id)!)")
        case 1:
                self.crawlers?.osori4[1].id
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[1].id, forKey: "Subscribe_id")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[1].title, forKey: "Subscribe_title")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[1].description, forKey: "Subscribe_des")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[1].image, forKey: "Subscribe_image")
                NSUserDefaults.standardUserDefaults().synchronize()
                print("subscribeid!\((self.crawlers?.osori4[1].id)!)")
            
        case 2: self.crawlers?.osori4[2].id
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[2].id, forKey: "Subscribe_id")
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[2].title, forKey: "Subscribe_title")
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[2].description, forKey: "Subscribe_des")
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[2].image, forKey: "Subscribe_image")
            NSUserDefaults.standardUserDefaults().synchronize()
        print("subscribeid!!\((self.crawlers?.osori4[2].id)!)")
        case 3: self.crawlers?.osori4[3].id
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[3].id, forKey: "Subscribe_id")
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[3].title, forKey: "Subscribe_title")
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[3].description, forKey: "Subscribe_des")
            NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[3].image, forKey: "Subscribe_image")
            NSUserDefaults.standardUserDefaults().synchronize()
        print("subscribeid!!!\((self.crawlers?.osori4[3].id)!)")
        case 4: self.crawlers?.osori4[4].id
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[4].id, forKey: "Subscribe_id")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[4].title, forKey: "Subscribe_title")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[4].description, forKey: "Subscribe_des")
                NSUserDefaults.standardUserDefaults().setObject(self.crawlers?.osori4[4].image, forKey: "Subscribe_image")
                NSUserDefaults.standardUserDefaults().synchronize()
                            print("subscribeid!!!!!!!\((self.crawlers?.osori4[4].id)!)")
        default: break
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

