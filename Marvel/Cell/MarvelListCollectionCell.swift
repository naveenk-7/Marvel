//
//  MarvelListCell.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import UIKit
import Kingfisher

class MarvelListCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var marvelListImage: UIImageView!
    
    // Update Cell UI
    func updateCell(model: Result) {
        title.text = model.name
        DispatchQueue.main.async {
            let imageURLString = model.thumbnail.path + Constants.dot + model.thumbnail.thumbnailExtension.rawValue
            let url = URL(string: imageURLString)
            self.marvelListImage.kf.setImage(with: url)
        }
    }
}
