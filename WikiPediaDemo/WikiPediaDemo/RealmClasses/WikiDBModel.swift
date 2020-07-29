//
//  WikiDBModel.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 29/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation
import RealmSwift


class WikiDBModel: Object {
     @objc dynamic var pageid : Int = 0
     @objc dynamic var canonicalurl : String = ""
     @objc dynamic var editurl : String = ""
     @objc dynamic var fullurl : String = ""
     @objc dynamic var title : String = ""
     @objc dynamic var touched : String = ""
     @objc dynamic var imageUrl : String = ""
     @objc dynamic var descriptiontext : String = ""
}
