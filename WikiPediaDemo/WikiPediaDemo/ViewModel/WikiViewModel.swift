//
//  WikiViewModel.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 28/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation

class WikiViewModel {
    let id : Int
    let title : String
    let detailTitle : String
    let thumbNailimageUrl : String?
    let fullUrl : String
    
    //Dependency Injection 
    init(wikiModel : WikiModel) {
        self.id = wikiModel.pageid
        self.title = wikiModel.title
        self.detailTitle = ""
        self.thumbNailimageUrl = ""
        self.fullUrl = wikiModel.fullurl
    }
    
    init(id : Int, title : String, detailTitle : String, thumbNailimageUrl : String?, fullUrl : String) {
        self.id = id
        self.title = title
        self.detailTitle = detailTitle
        self.thumbNailimageUrl = thumbNailimageUrl
        self.fullUrl = fullUrl
    }
    
}
