//
//  ModelListViewModel.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import Foundation
import Alamofire

protocol MarvelListViewModelDelegate: NSObjectProtocol {
    func marvelListResponse()
}

class MarvelListViewModel {
    
    weak var delegate: MarvelListViewModelDelegate?
    var marvelModelList: Marvel?
    
    // Fetch marvel list
    func fetchMarvelList() {
        AF.request(APIRouter.listPage).response { response in
            guard response.error == nil else {
                print(response.error as Any)
                self.delegate?.marvelListResponse()
                return
            }
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(Marvel.self, from: data)
                    self.marvelModelList = result
                    self.delegate?.marvelListResponse()
                }
                catch {
                    print(response.error.debugDescription as Any)
                    self.delegate?.marvelListResponse()
                }
            }
            else {
                print(response.error.debugDescription)
                self.delegate?.marvelListResponse()
            }
        }
    }
}
