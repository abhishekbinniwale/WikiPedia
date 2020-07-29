//
//  SearchListTableViewCell.swift
//  WikiPediaDemo
//
//  Created by Abhishek Binniwale on 28/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(wikiViewModel : WikiViewModel){
        self.titleLabel.text = wikiViewModel.title
        self.detailLabel.text = wikiViewModel.detailTitle == "" ? "Detail text" : wikiViewModel.detailTitle 
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        
        if  let imageUrl = wikiViewModel.thumbNailimageUrl {
            //Call a image data fetch on Background thread
            //Set image on main thread
            DispatchQueue.global(qos: .background).async {
                APIManager.sharedInstance.fetchImageData(urlString: imageUrl) { (data) in
                    if let imageData = data {
                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
    
    
}
