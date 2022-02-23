//
//  MarvelDetailTableCell.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import UIKit
import Kingfisher

class MarvelDetailTableCell: UITableViewCell {
    
    @IBOutlet private weak var marvelDetailImage: UIImageView!
    @IBOutlet private weak var marvelDetailDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Update Cell UI
    func updateCell(model: Result) {
        DispatchQueue.main.async {
            let imageURLString = model.thumbnail.path + Constants.dot + model.thumbnail.thumbnailExtension.rawValue
            let url = URL(string: imageURLString)
            self.marvelDetailImage.kf.setImage(with: url)
        }
        marvelDetailDescription.text = model.description
    }

}
