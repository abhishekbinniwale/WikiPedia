//
//  APIManager.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 28/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//



import Foundation

///This is A singleton class for Network Calls
class APIManager {
    
    static let sharedInstance = APIManager()
    var wikiModels = [WikiModel]()
    
    
    ///Fetch WikiModel for search string passed and return completion block
    func fetchWikiData(searchtext: String, completion :@escaping (_ wikiViewModel : [WikiModel])-> Void) {
        let searchString = searchtext.replacingOccurrences(of: " ", with: "+")
        let urlString =
        "https://en.wikipedia.org//w/api.php?action=query&formatversion=2&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&prop=info&inprop=url&gpssearch=\(searchString)&gpslimit=10"
        
        
        wikiModels = []
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("Error while fetching data :\(String(describing: error))")
                    return
                }
                
                if let jsonData = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] {
                            print("JSON data :\(json)")
                            
                            if let query = json["query"] as? [String : Any] {
                                if let pages = query["pages"] as? [[String : Any]] {
                                    print("Pages :\(pages)")
                                    for page in pages {
                                        let pageid = page["pageid"] as? Int ?? 0
                                        let canonicalurl =  page["canonicalurl"] as?String ?? ""
                                        let editurl  =  page["editurl"] as?String ?? ""
                                        let fullurl  =  page["fullurl"] as?String ?? ""
                                        let title  =  page["title"] as?String ?? ""
                                        let touched  =  page["touched"] as?String ?? ""
                                        
                                        let wikiModel = WikiModel(pageid: pageid, canonicalurl: canonicalurl, editurl: editurl, fullurl: fullurl, title: title, touched: touched)
                                        self.wikiModels.append(wikiModel)
                                    }
                                }
                                completion(self.wikiModels)
                            }
                        }
                        
                    }catch let error {
                        print("Error while JSON serialization error :\(error)")
                        completion(self.wikiModels)
                    }
                } else {
                    print("Data is nil")
                    completion(self.wikiModels)
                }
            }
            task.resume()
        }
    }
    
    ///fetch Image data from gievn url string and return completion block
    func fetchImageData(urlString : String, completion :@escaping(_ imageData : Data?)-> Void) {
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error while fetching image data :\(String(describing: error))")
                    completion(nil)
                }
                
                if let imagedata = data {
                    completion(imagedata)
                }
            }
            dataTask.resume()
        }
    }
    
    ///Return WikiModel by Pageid
    func getModelObjectByid(id : Int) -> WikiModel? {
        return self.wikiModels.filter{ $0.pageid == id }.first
    }
}
