//
//  EntireCrawlerController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 15..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage

class EntireCrawlerController: UIViewController {
    
    var entireCrawlerTableView: UITableView!
    
    var localCrawlerList: [CrawlerList]! = []
    
    var requestToken: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "전체리스트"
    }
    
    init(crawlerList: [CrawlerList], token: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = "전체리스트"
        for crawler in crawlerList {
            localCrawlerList.append(crawler)
        }
        requestToken = token
        print("requestToken \(requestToken)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        entireCrawlerTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - (self.tabBarController?.tabBar.frame.height)! - (self.navigationController?.navigationBar.frame.height)! - statusHeight))
        entireCrawlerTableView.delegate = self
        entireCrawlerTableView.dataSource = self
        entireCrawlerTableView.tableFooterView = UIView(frame: .zero)
        entireCrawlerTableView.register(EntireCrawlerCell.self, forCellReuseIdentifier: "EntireCrawlerCell")
        
        self.view.addSubview(entireCrawlerTableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension EntireCrawlerController {
    func subscribeAction(indexPath: IndexPath) {
        let crawler_id = self.localCrawlerList[indexPath.row].crawler_id!
        Alamofire.request(serverURL + "/subscription/", method: .post, parameters: ["crawler_id": crawler_id], encoding: JSONEncoding.default, headers: ["Authorization" : "Token " + requestToken!]).responseJSON { (subscriptionRes) in
            print("subscriptionRes.result \(subscriptionRes.result)")
            switch subscriptionRes.result {
            case.success(let data):
                let serverResult = data as! [String: Any]
                print("serverResult \(serverResult)")
                let getCrawlerErrorCode = serverResult["ErrorCode"] as! Int
                switch getCrawlerErrorCode {
                case 0:
                    NotificationCenter.default.post(name: .notiSubscribe, object: nil)
                case -101:
                    print("크롤러 데이터 전송좀")
                case -200:
                    print("그런 크롤러 없음")
                default:
                    print("서버 에러")
                }
            case.failure(let err):
                print("err \(err)")
            }
        }
    }
}

extension EntireCrawlerController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localCrawlerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntireCrawlerCell", for: indexPath) as! EntireCrawlerCell
        cell.crawlerImage.image = UIImage(named: localCrawlerList[indexPath.row].thumbnail_url!)
        if(cell.crawlerImage.image == nil) {
            cell.crawlerImage.image = UIImage(named: "juju")
        }
        cell.crawlerTitle.text = localCrawlerList[indexPath.row].title
        cell.crawlerDescription.text = localCrawlerList[indexPath.row].description
        cell.subscribeAction = {
            (celll) in
            self.subscribeAction(indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
