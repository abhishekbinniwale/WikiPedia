//
//  DetailViewController.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 29/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController , WKNavigationDelegate{

    @IBOutlet weak var webViewOutlet: WKWebView!
    
    var wikiViewModel : WikiViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWebView()
        self.saveVisitedWikiPageToDB()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        webViewOutlet.stopLoading()
    }
    ///Load Wiki page of given URL
    func loadWebView(){
        if let profileUrl = wikiViewModel?.fullUrl {
            if  let web_url = URL(string:profileUrl){
                let web_request = URLRequest(url: web_url)
                webViewOutlet.navigationDelegate = self
                webViewOutlet.load(web_request)
            }
        }
    }
    
    ///Save visied page data in DB for offline storage
    func  saveVisitedWikiPageToDB(){
        ///Pass selected Model ID to DB manager and save it in to DB
        if let pageID = wikiViewModel?.id {
            DBManager.sharedInstance.saveWikiModelInDBwithid(id: pageID)
        }
    }
    
}
