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
                        
                        //let newCrawler = Crawler(json:(jsonCrawler as! [String : AnyObject]))
                        //self.crawlers[newCrawler.id] = newCrawler
                        
                        let newCrawler = Crawler(json:(jsonCrawler as! [String : AnyObject]))
                        crawlers[newCrawler.id] = newCrawler
                        print(newCrawler.title)
                        print(newCrawler.description)
                        print(newCrawler.thumbnailURL)
                        osori4.append(Osori(title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL))
                    
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
    
   
    
    
    let item1 = String(UIImage(named:"soccer"),"해외축구 일정 결과")
    let item2 = String(UIImage(named:"hanyang"),"한양대 컴퓨터전공 공지사항")
    var items:[String] = ["한양대 컴퓨터전공 공지사항","네이버 실시간 검색어 순위","남도학숙 주간 시간표","디시인사이드 힛갤러리 목록","해외축구 일정 결과","Zangsisi 최신화","LOL 패치노트","Steam 세일"]
    
    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var Crawler:String?
    var imageURL:UIImageView?
    var realimage:UIImage?
    //let image_url:UIImageView? = nil
    
    var osori = [Osori]()
    var count:Int?
    func loadSampleData(){
        /*osori.append(Osori(str: "한양대 컴퓨터전공 공지사항", image: UIImage(named: "hanyang")!))
        osori.append(Osori(str: "네이버 실시간 검색어 순위", image: UIImage(named: "naver")!))
        osori.append(Osori(str: "남도학숙 주간 시간표", image: UIImage(named: "namdo")!))
        osori.append(Osori(str: "디시인사이드 힛갤러리 목록", image: UIImage(named: "dc")!))
        osori.append(Osori(str: "해외축구 일정 결과", image: UIImage(named: "soccer")!))
        osori.append(Osori(str: "Zangsisi 최신화", image: UIImage(named: "zang")!))
        osori.append(Osori(str: "LOL 패치노트", image: UIImage(named: "lol")!))
        osori.append(Osori(str: "Steam 세일", image: UIImage(named: "steam")!))
 */
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        print("in EntrireList!!!")
        if((userID != nil) && (userKey != nil))
        {
            makePostRequest()
        }
        
        //self.tableview2.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func makePostRequest(){
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_entire_list")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        
        
        
        print("user id! \(userID!)")
        print("user key! \(userKey!)")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)"
        
        
        print("postString! : \(postString)")
        
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("responseString = \(responseString!)")
            
            
            self.crawlers = Crawlers(jsonString: responseString as! String)
            self.count = (self.crawlers?.osori4.count)!
            self.tableview2.reloadData()
            
            //for i in crawlers.crawlers.count
            //{
             //   print(crawlers.crawlers[i])
            //}
            
                /*
                var data: NSData = responseString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                
            
                if let crawlers = json["crawlers"]
                {
                    
                    print(crawlers![0])
                    crawlers![1]
                    if let crawler_title_steam = crawlers![0]["title"]
                    {
                        print(crawler_title_steam!)
                        self.osori.append(Osori(str: "Zangsisi 최신화",description: crawler_title_steam!, image: UIImage(named: "zang")!))
                    }
                }
 */
        //let count = (self.crawlers?.osori4.count)!
        print("count!!!!!!!!!!!!!!!\(self.crawlers?.osori4.count)!")
        print("count22222 :::::\(self.crawlers?.osori4.count)")
            
        print("real count!!!!!!!!!!!\(self.count)")
        }
        task.resume()
        
        
        
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
        
        

        
        //cell2.textLabel?.text = self.crawlers?.osori4[indexPath.row].description
        
        //let theme = themes[indexPath.row]
        
        
        //let urldata:String = crawlers?.osori4[indexPath.row].image
        
        /*if let url  = NSURL(urldata),
            data = NSData(contentsOfURL: url)
        {
            imageURL.image = UIImage(data: data)
        }
        
        //cell2.imageView?.imageURL = imageURL.image
        
        cell2.append([labeltext])
        cell2.beginUpdates()
        cell2.insertRowsAtIndexPaths([
            NSIndexPath(forRow: Yourarray.count-1, inSection: 0)
            ], withRowAnimation: .Automatic)
        
        cell2.endUpdates()
        */
        return cell2
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

