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
                        self.crawlers[newCrawler.id] = newCrawler
                    }
                    
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
    }
    
    
    let item1 = String(UIImage(named:"soccer"),"해외축구 일정 결과")
    let item2 = String(UIImage(named:"hanyang"),"한양대 컴퓨터전공 공지사항")
    var items:[String] = ["한양대 컴퓨터전공 공지사항","네이버 실시간 검색어 순위","남도학숙 주간 시간표","디시인사이드 힛갤러리 목록","해외축구 일정 결과","Zangsisi 최신화","LOL 패치노트","Steam 세일"]
    
    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var Crawler:String?
    
    var osori = [Osori]()
    
        
    func loadSampleData(){
        osori.append(Osori(str: "한양대 컴퓨터전공 공지사항", image: UIImage(named: "hanyang")!))
        osori.append(Osori(str: "네이버 실시간 검색어 순위", image: UIImage(named: "naver")!))
        osori.append(Osori(str: "남도학숙 주간 시간표", image: UIImage(named: "namdo")!))
        osori.append(Osori(str: "디시인사이드 힛갤러리 목록", image: UIImage(named: "dc")!))
        osori.append(Osori(str: "해외축구 일정 결과", image: UIImage(named: "soccer")!))
        osori.append(Osori(str: "Zangsisi 최신화", image: UIImage(named: "zang")!))
        osori.append(Osori(str: "LOL 패치노트", image: UIImage(named: "lol")!))
        osori.append(Osori(str: "Steam 세일", image: UIImage(named: "steam")!))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        print("in EntrireList!!!")
        if((userID != nil) && (userKey != nil))
        {
            makePostRequest()
        }
        loadSampleData()
        
        self.tableview2.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        
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
            print("responseString = \(responseString!)")
            
            do
            {
                var crawlers = Crawlers(jsonString: responseString as! String)
                
                var data: NSData = responseString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let message = json["message"]
                {
                    print(message!)
                }
                if let erroCode = json["error"]
                {
                    print(erroCode!)
                }
                if let crawlers = json["crawlers"]
                {
                    print(crawlers)
                    
                    
                    print(1)
                    print(crawlers![0])
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
        task.resume()
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return osori.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2:UITableViewCell = self.tableview2.dequeueReusableCellWithIdentifier("cell2")! as UITableViewCell
        cell2.textLabel?.text = self.osori[indexPath.row].str
        cell2.imageView?.image = self.osori[indexPath.row].image
        
        return cell2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

