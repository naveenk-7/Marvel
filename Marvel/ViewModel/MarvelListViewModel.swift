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
    func fetchMarvelCharactersList()
}

class MarvelListViewModel {
    
    weak var delegate: MarvelListViewModelDelegate?
    var marvelModelList: Marvel?
    var marvelResultList = [Result]()
    
    // Fetch marvel list
    func fetchMarvelList(offsetValue: Int) {
        AF.request(APIRouter.listPage(offset: offsetValue)).response { response in
            guard response.error == nil else {
                print(response.error as Any)
                self.delegate?.marvelListResponse()
                return
            }
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(Marvel.self, from: data)
                    self.marvelModelList = result
                    self.marvelResultList.append(contentsOf: result.data.results)
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
    
    // To find the last cell and make api call
    func isLastCell(indexRow: Int) {
        if let total = self.marvelModelList?.data.total {
            if indexRow == marvelResultList.count - 1 && indexRow < total {
                self.delegate?.fetchMarvelCharactersList()
            }
        }
    }
}
