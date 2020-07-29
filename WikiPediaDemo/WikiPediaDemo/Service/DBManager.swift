//
//  DBManager.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 29/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation
import RealmSwift

///This is A Singleton class for DB operation .
class DBManager {

    static let sharedInstance = DBManager()
    
    func saveWikiModelInDBwithid(id: Int){
        ///get visited Model entry from APIManager class
        if let model = APIManager.sharedInstance.getModelObjectByid(id: id) {
            ///Save visited Wiki page in DB
            let dbEntry = WikiDBModel()
            dbEntry.pageid = model.pageid
            dbEntry.canonicalurl = model.canonicalurl
            dbEntry.fullurl = model.fullurl
            dbEntry.editurl = model.editurl
            dbEntry.title = model.title
            dbEntry.touched = model.touched
            
            do {
                let realm = try Realm()
                try realm.write{
                    realm.add(dbEntry)
                }
            } catch let error {
                print("Error while saving db entry :\(error)")
            }
        } else {
            print("Model nit found with pageid :\(id)")
        }
    }
    
    func fetchAllStoredWikiModel(completion:@escaping (_ wikiViewModel:[WikiViewModel]?) -> Void){
        ///Fetch all stored models and return viewmodel to Viewcontroller
        print("Realm DB path :\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        do {
            let realm = try Realm()
            
            let result = realm.objects(WikiDBModel.self)
            var wikiViewModels = [WikiViewModel]()
            for dbModel in result {
                 let wikiViewModel =  WikiViewModel(id: dbModel.pageid, title: dbModel.title, detailTitle: dbModel.descriptiontext, thumbNailimageUrl: dbModel.imageUrl, fullUrl: dbModel.fullurl)
                wikiViewModels.append(wikiViewModel)
            }
            print(wikiViewModels)
            completion(wikiViewModels)
        } catch let error {
            print("Error while fetching DB data :\(error)")
            completion(nil)
        }
    }
    
}
