//
//  MarvelDetailViewController.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import UIKit

class MarvelDetailViewController: UIViewController {
    
    var characterID = 0
    var pageTitle: String?
    var marvelDetail = MarvelDetailViewModel()
    @IBOutlet weak var marvelDetailTableView: UITableView!
    
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
    }

}

// MARK: - TableView delegate, datasource methods
extension MarvelDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.marvelDetailTableCell) as? MarvelDetailTableCell else
        { return UITableViewCell() }
        if let value = marvelDetail.marvelModelDetail?.data.results[indexPath.row] {
            cell.updateCell(model: value)
        }
        return cell
    }
}


// MARK: - Marvel detail model delegate
extension MarvelDetailViewController: MarvelDetailViewModelDelegate {
    
    func marvelDetailResponse() {
        if marvelDetail.marvelModelDetail?.data.results.count ?? 0 > 0 {
            marvelDetailTableView.reloadData()
        }
        hideActivityIndicator()
    }
}
