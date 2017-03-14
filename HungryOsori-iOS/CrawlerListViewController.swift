//
//  CrawlerListViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SDWebImage



class CrawlerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet
    var crawlerTableview:UITableView!
    var crawlers:Crawlers? = Crawlers()
    var imageURL:UIImageView?
    var realimage:UIImage?
    var count:Int?
    var sub_id_for_reqe:String?
    var temp_unsubscription = [String]()
    var temp_pushToken:String?
    var responsestring:NSString?
    var mgr: Alamofire.SessionManager!

    override func viewDidLoad() {
        userKey = UserDefaults.standard.string(forKey: "New_user_key")
        
        let refreshedToken = FIRInstanceID.instanceID().token()!
        temp_pushToken = refreshedToken
        print("InstanceID token: \(refreshedToken)")
        super.viewDidLoad()
        mgr = configureManager()
        makePostRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.crawlerTableview.reloadData()
    }
    
    func makePostRequest(){
        
        
        mgr.request(string_url+"/crawlers/", method: .get).responseString { (response) in
            print("=================================================")
            print("response for crawlers : \(response)")
            self.responsestring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
            self.crawlers = Crawlers(jsonString: (self.responsestring as! String))
            for crawler in (self.crawlers?.crawler_list)! {
                ShareData.sharedInstance.entireList.append(Crawler(id: crawler.id, title: crawler.title, description: crawler.description, image: crawler.thumbnailURL, link_url : crawler.link_url))
            }
//
//            for i in 0...2{
//                let id:String?  = self.crawlers!.crawler_list[i].id
//                let title:String? = self.crawlers!.crawler_list[i].title
//                let des:String? = self.crawlers!.crawler_list[i].description
//                let image:String? = self.crawlers!.crawler_list[i].thumbnailURL
//                let link_url: String? = self.crawlers!.crawler_list[i].link_url
//                ShareData.sharedInstance.entireList.append(Crawler(id: id!, title: title!, description: des!, image: image!, link_url : link_url!))
//                }
            self.count = (self.crawlers!.crawler_list.count)
            self.crawlerTableview.reloadData()
        }
    }
    
    func makePostRequestScrcibe(){
        let subid = sub_id_for_reqe
        let latest_pushtime : String? =  "2016:12:28"
        mgr.request(string_url+"/subscriptions/",method: .post,  parameters: ["user_id" : userID!,"user_key" : userKey!,"crawler_id" : subid!, "latest_pushtime" : latest_pushtime!]).responseString { (response) in
            print("result ????? : \(response.result)")   // result of response serialization
            switch(response.result) {
            case .success(_):
                    print("messae sucess!!!")
                    break
                
            case .failure(_):
                print("test response failure : \(response.result.error)")
                break
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (count == nil)
        {
            return 0
        }
        else{
            return count!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = crawlerTableview.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! MyTableViewCell
        let cc = self.crawlers!.crawler_list[(indexPath as NSIndexPath).row]
        print("cc.thumnailURL   \(cc.thumbnailURL)")
        cell2.title.text = cc.title
        cell2.des.text = cc.description
        let imgURL: URL = URL(string: cc.thumbnailURL)!

        cell2.imageurlresult.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "second"))
        if((ShareData.sharedInstance.unsubscriptionList.count) != 0)
        {
            for j in 0...(ShareData.sharedInstance.unsubscriptionList.count-1)
            {
                if(cc.id == ShareData.sharedInstance.unsubscriptionList[j].id)
                {
                    cell2.subscribeButton.setTitle("구독", for: UIControlState())

                }
            }
        }
        cell2.subscribeButton.tag = (indexPath as NSIndexPath).row
            return cell2
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cc = self.crawlers!.crawler_list[(indexPath as NSIndexPath).row]
        webURL = cc.link_url
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dstination = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        present(dstination, animated: true, completion: nil)
        
    }
    @IBAction func subscribebutton(_ sender: UIButton) {
        sender.setTitle("해제", for: UIControlState())
        sub_id_for_reqe = self.crawlers?.crawler_list[sender.tag].id
        makePostRequestScrcibe()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("why error\(error)")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}


