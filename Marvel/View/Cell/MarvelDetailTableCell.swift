//
//  MarvelDetailTableCell.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import UIKit
import Kingfisher

class MarvelDetailTableCell: UITableViewCell {
    
    @IBOutlet private weak var marvelSeries: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Update Cell UI
    func updateCell(name: String) {
        marvelSeries.text = name
    }

}
