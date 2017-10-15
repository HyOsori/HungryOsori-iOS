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
    
    var testCrawlerList: [CrawlerList]! = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "전체리스트"
        let testC1 = CrawlerList(id: "1", title: "test1 title", description: "test1 description", thumnailURL: "test1", link_url: "test1")
        let testC2 = CrawlerList(id: "2", title: "test2 title", description: "test2 description", thumnailURL: "test2", link_url: "test2")
        let testC3 = CrawlerList(id: "3", title: "test3 title", description: "test3 description", thumnailURL: "test3", link_url: "test3")
        let testC4 = CrawlerList(id: "4", title: "test4 title", description: "test4 description", thumnailURL: "test4", link_url: "test4")
        testCrawlerList.append(testC1)
        testCrawlerList.append(testC2)
        testCrawlerList.append(testC3)
        testCrawlerList.append(testC4)
        testCrawlerList.append(testC1)
        testCrawlerList.append(testC2)
        testCrawlerList.append(testC3)
        testCrawlerList.append(testC4)
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

extension EntireCrawlerController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testCrawlerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntireCrawlerCell", for: indexPath) as! EntireCrawlerCell
        cell.crawlerImage.image = UIImage(named: testCrawlerList[indexPath.row].thumnailURL!)
        cell.crawlerTitle.text = testCrawlerList[indexPath.row].title
        cell.crawlerDescription.text = testCrawlerList[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
