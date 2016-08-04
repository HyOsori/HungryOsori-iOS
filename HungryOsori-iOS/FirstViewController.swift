//
//  FirstViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    
    var subscriptions = []
    /*
    public struct Crawlers
    {
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
    
    var items:[String] = ["한양대 컴퓨터전공 공지사항","네이버 실시간 검색어 순위","남도학숙 주간 시간표","디시인사이드 힛갤러리 목록","해외축구 일정 결과","Zangsisi 최신화","LOL 패치노트","Steam 세일"]
    */
    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    let sub_id = NSUserDefaults.standardUserDefaults().stringForKey("Subscribe_id")
    
    let sub_title = NSUserDefaults.standardUserDefaults().stringForKey("Subscribe_title")
    let sub_des = NSUserDefaults.standardUserDefaults().stringForKey("Subscribe_des")
    let sub_img = NSUserDefaults.standardUserDefaults().stringForKey("Subscribe_image")
    let subarray = NSUserDefaults.standardUserDefaults().objectForKey("Subscribe")
    var osori3 = [Osori]()
    //var osori4 = [Osori]()
    var count:Int?
    //NSUserDefaults.standardUserDefaults().stringForKey("Subscribe")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if((userID != nil) && (userKey != nil))
        {
            makePostRequest()
        }
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func makePostRequest(){
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_subscription_list")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        
        
        
        print("user id! \(userID!)")
        print("user key! \(userKey!)")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)"
        
        
        print("postString! : \(postString)")
        
        
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
            
            do {
                let JsonData =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = JsonData {
                    
                    // Now we can access value of First Name by its key
                    //messageDecision = parseJSON["message"] as? String
                    self.subscriptions = (parseJSON["subscriptions"])! as! NSArray
                    
                    print("Subscription list id : \(self.subscriptions)")
                }
            } catch {
                print(error)
            }
            print("responseStringggggggggggggg + title + des + urlimg\(responseString)\(self.sub_title!)\(self.sub_des!)\(self.sub_img!)")
            //print("responseStringggggggggggggg + title + des + urlimg\(responseString)\(self.subarray)")
            //self.osori4.append(Osori.init(id: self.sub_id!, title: (self.subarray![1]! as? String)!, description: (self.subarray![2]! as? String)!, image: (self.subarray![3]! as? String)!))
            //self.osori3.append(Osori(id: self.sub_id!, title: self.sub_title!, description: self.sub_des!, image: self.sub_img!))
            self.appnd()
            self.count = self.subscriptions.count
            
            self.count = (self.osori3.count)
            print("count num!!!!!!!!!!!\((self.count)!)")
            //self.tableView.reloadData()
        }
        task.resume()
        
        
        
    }
    func appnd()
    {
        self.osori3.append(Osori(id: self.sub_id!, title: self.sub_title!, description: self.sub_des!, image: self.sub_img!))
        self.count = self.osori3.count
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.count == nil)
        {
            print("count if nil \(self.count)")
            return 1
        }else{
            print("count if not nil \(self.count)")
            return self.count!
        }
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let subcell = tableView.dequeueReusableCellWithIdentifier("subcell", forIndexPath: indexPath) as! SubscribeTableViewCell
        print("indexpath.row \(indexPath.row)")
        print("count!!!! \(self.count)")
        //self.tableView.reloadData()
        
        subcell.subtitle.text = self.osori3[indexPath.row].title
        subcell.subdes.text = self.osori3[indexPath.row].description
        
        
        let unwrapped:String = self.osori3[indexPath.row].image
        let url = NSURL(string: unwrapped)!
        
        if let data = NSData(contentsOfURL : url)
        {
            if let realimage = UIImage(data: data)
            {
                subcell.subimage.image = realimage
                if(subcell.subimage.image == nil)
                {
                    print("threre is no image!!")
                }
            }
        }
                return subcell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
