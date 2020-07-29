//
//  HomeScreenViewController.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 28/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController , UISearchBarDelegate{

    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var wikiViewModels = [WikiViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "SearchListTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchListTableViewCell")
        self.searchBarOutlet.showsCancelButton = true
        setUPUI()
    }
    ///SetUp ui on SB fetch result
    func setUPUI(){
        ///Nedds to fetch the stored records in DB and show in UI
         DBManager.sharedInstance.fetchAllStoredWikiModel { (wikiModels) in
            print("Already visited model :\(String(describing: wikiModels))")
            if let models = wikiModels {
                self.UpdateUI(viewModels: models)
            }
        }
    }
    ///Update UI according to search reesult / Db fetch
    func UpdateUI(viewModels :[WikiViewModel]) {
        DispatchQueue.main.async {
            self.wikiViewModels.removeAll()
            self.wikiViewModels = viewModels
            self.tableView.reloadData()
        }
    }
    ///On search button click fetch a Wikidata by search string
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing gets called")
        self.searchBarOutlet.resignFirstResponder()
        if let searchText =  self.searchBarOutlet.searchTextField.text {
            APIManager.sharedInstance.fetchWikiData(searchtext: searchText) { (wikiModels) in
                print("Wiki Models :\(wikiModels)")
                var searchResultWikiViewModels = [WikiViewModel]()
                for model in wikiModels {
                    searchResultWikiViewModels.append(WikiViewModel(wikiModel: model))
                }
                self.UpdateUI(viewModels: searchResultWikiViewModels)
            }
        }
    }
    ///On search bar cancel button click show the saved data on UI.
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarOutlet.resignFirstResponder()
        self.searchBarOutlet.searchTextField.text = ""
        self.setUPUI()
    }
}

///Extension for UItableView Delegate and DataSource method
extension HomeScreenViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wikiViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell", for: indexPath) as? SearchListTableViewCell {
            let model = wikiViewModels[indexPath.row]
            cell.configureCell(wikiViewModel: model)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailView.wikiViewModel = wikiViewModels[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
