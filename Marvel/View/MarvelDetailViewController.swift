//
//  MarvelDetailViewController.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import UIKit
import Kingfisher

class MarvelDetailViewController: UIViewController {
    
    var characterID = 0
    var pageTitle: String?
    var marvelDetail = MarvelDetailViewModel()
    @IBOutlet weak var marvelDetailTableView: UITableView!
    @IBOutlet weak var marvelDetailImage: UIImageView!
    @IBOutlet weak var marvelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    // Initial method
    func setUp(){
        self.navigationItem.title = pageTitle
        marvelDetail.delegate = self
        showActivityIndicator()
        // Fetch marvel detail API
        marvelDetail.fetchMarvelDetail(characterID: characterID)
        marvelDetailTableView.alwaysBounceVertical = false
    }

}

// MARK: - TableView delegate, datasource methods
extension MarvelDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.marvelDetail.marvelModelDetail?.data.results[0].series.items.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.marvelDetailTableCell) as? MarvelDetailTableCell else
        { return UITableViewCell() }
        if let name = self.marvelDetail.marvelModelDetail?.data.results[0].series.items[indexPath.row].name { //marvelDetail.marvelModelDetail?.data.results[indexPath.row] {
            cell.updateCell(name: name)
        }
        return cell
    }
}


// MARK: - Marvel detail model delegate
extension MarvelDetailViewController: MarvelDetailViewModelDelegate {
    
    func marvelDetailResponse() {
        if marvelDetail.marvelModelDetail?.data.results.count ?? 0 > 0 {
            marvelDetailTableView.reloadData()
            if let value = self.marvelDetail.marvelModelDetail?.data.results[0] {
                DispatchQueue.main.async {
                    let imageURLString = value.thumbnail.path + Constants.dot + value.thumbnail.thumbnailExtension.rawValue
                    let url = URL(string: imageURLString)
                    self.marvelDetailImage.kf.setImage(with: url)
                }
                marvelDescription.text = value.description
            }
        }
        hideActivityIndicator()
    }
}
