//
//  FindPasswordController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 15..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire

class FindPasswordController: UIViewController {

    var previousPage: UIButton!
    
    var inputIDLabel: UILabel!
    
    var inputIDTextField: UITextField!
    
    var findButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewConfig()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FindPasswordController {
    func viewConfig() {
        previousPage = UIButton(frame: CGRect(x: self.view.frame.width/20, y: self.view.frame.height/16, width: self.view.frame.width/2, height: self.view.frame.height/16))
        
        previousPage.setTitle("이전 페이지", for: .normal)
        previousPage.setTitleColor(.blue, for: .normal)
        previousPage.contentHorizontalAlignment = .left
        previousPage.addTarget(self, action: #selector(onClickPreviousPage(_:)), for: .touchUpInside)
        
        inputIDLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/4, y: self.view.frame.height - self.view.frame.height*4/5, width: self.view.frame.width/2, height: previousPage.frame.height))
        inputIDLabel.textAlignment = .center
        inputIDLabel.text = "아이디를 입력하세요 : "
        inputIDLabel.textColor = .blue
        
        inputIDTextField = UITextField(frame: CGRect(x: inputIDLabel.frame.origin.x, y: inputIDLabel.frame.origin.y + inputIDLabel.frame.height, width: inputIDLabel.frame.width, height: inputIDLabel.frame.height))
        inputIDTextField.placeholder = "ID"
        inputIDTextField.borderStyle = .roundedRect
        
        findButton = UIButton(frame: CGRect(x: inputIDTextField.frame.origin.x, y: inputIDTextField.frame.origin.y + inputIDTextField.frame.height + 10, width: inputIDTextField.frame.width, height: inputIDTextField.frame.height))
        findButton.setTitle("찾기", for: .normal)
        findButton.setTitleColor(.blue, for: .normal)
        findButton.titleLabel?.textAlignment = .center
        findButton.addTarget(self, action: #selector(onClickFindButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(previousPage)
        self.view.addSubview(inputIDLabel)
        self.view.addSubview(inputIDTextField)
        self.view.addSubview(findButton)
    }
    
    func onClickPreviousPage(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func onClickFindButton(_ sender: UIButton) {
        print("onClickFindButton")
    }
}
