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
    
    
    
    let item1 = String(UIImage(named:"soccer"),"해외축구 일정 결과")
    let item2 = String(UIImage(named:"hanyang"),"한양대 컴퓨터전공 공지사항")
    var items:[String] = ["한양대 컴퓨터전공 공지사항","네이버 실시간 검색어 순위","남도학숙 주간 시간표","디시인사이드 힛갤러리 목록","해외축구 일정 결과","Zangsisi 최신화","LOL 패치노트","Steam 세일"]
    
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

        makePostRequest()
        loadSampleData()
        
        self.tableview2.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func makePostRequest(){
 //       let urlPath: String = "192.168.0.89"
        
 //       let myURL:NSURL = NSURL(string: urlPath)!
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_entire_list")!)
 //       let request = NSMutableURLRequest(URL: myURL)
        request.HTTPMethod = "POST"
        //let json = ["result":"0","message":"success","crawlers":["crawler_id":"string","title":"string","Descrption":"string","item_URL":"URL"]]
    
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print("success \(httpResponse.statusCode)")
            }
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
           // let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
           // print("responseString = \(responseString)")
            
            // Convert server json response to NSDictionary
            
            
            do {
                if let JsontoDic = try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as? NSDictionary {
                    
    //                if let dictionary = JsontoDic as? [String : AnyObject]
     //               {
      //                  self.readJSONObject(dictionary)
        //            }
                    
                    // Get value by key
                    let firstNameValue = JsontoDic["sdhfi3"] as? String
                    let Crawlers = JsontoDic["crawlers.sdhfi3"] as? [[String: AnyObject]]
                    print(Crawlers)
                    print(firstNameValue)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
    func readJSONObject(object: [String: AnyObject]) {
        guard let result = object["Result"] as? String,
            let message = object["Message"] as? String,
            let Crawlers = object["crawlers"] as? [[String: AnyObject]]
            else { return }
        
        for crawler in Crawlers {
            guard let crawler_id = crawler["crawler_id"] as? String,
                let title = crawler["title"] as? String,
                let description = crawler["description"] as? String,
                let imageURL = crawler["ImageURL"] as? String
                else { break }
        }
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

