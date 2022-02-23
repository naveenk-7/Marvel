//
//  ViewController.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import UIKit
import Alamofire

class MarvelListViewController: UIViewController {
    
    var marvelList = MarvelListViewModel()
    @IBOutlet private weak var marvelListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    // Initial method
    func setUp() {
        self.navigationItem.title = Constants.marvel
        marvelList.delegate = self
        showActivityIndicator()
        // Fetch marvel list API
        marvelList.fetchMarvelList()
    }

}

// MARK: - CollectionView delegate, datasource methods
extension MarvelListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marvelList.marvelModelList?.data.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.marvelListCollectionCell, for: indexPath as IndexPath) as? MarvelListCollectionCell else { return UICollectionViewCell() }
        if let value = marvelList.marvelModelList?.data.results[indexPath.row] {
            // Update cell
            cell.updateCell(model: value)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let marvelDetailView = self.storyboard?.instantiateViewController(withIdentifier: Constants.marvelDetailViewController) as? MarvelDetailViewController {
            marvelDetailView.characterID = marvelList.marvelModelList?.data.results[indexPath.row].id ?? 0
            marvelDetailView.pageTitle = marvelList.marvelModelList?.data.results[indexPath.row].name
            self.navigationController?.pushViewController(marvelDetailView, animated: true)
        }
    }
    
}

// MARK: - Marvel list model delegate
extension MarvelListViewController: MarvelListViewModelDelegate {
    
    func marvelListResponse() {
        if marvelList.marvelModelList?.data.results.count ?? 0 > 0 {
            marvelListCollectionView.reloadData()
        }
        hideActivityIndicator()
    }
}

