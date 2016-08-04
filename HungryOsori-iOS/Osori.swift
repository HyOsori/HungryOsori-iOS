//
//  Osori.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 14..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation
import UIKit

class Osori
{
    var id:String
    var title:String
    var description:String
    var image:String


    init(id:String, title : String,description: String, image : String)
    {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        
    }
}