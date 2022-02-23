//
//  MarvelDetailViewModel.swift
//  Marvel
//
//  Created by Naveen Kumar on 23/02/22.
//

import Foundation
import Alamofire

protocol MarvelDetailViewModelDelegate: NSObjectProtocol {
    func marvelDetailResponse()
}

class MarvelDetailViewModel {
    
    weak var delegate: MarvelDetailViewModelDelegate?
    var marvelModelDetail: Marvel?
    
    // Fetch marvel detail
    func fetchMarvelDetail(characterID: String) {
        AF.request(APIRouter.detailPage(characterID: characterID)).response { response in
            guard response.error == nil else {
                print(response.error as Any)
                self.delegate?.marvelDetailResponse()
                return
            }
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(Marvel.self, from: data)
                    self.marvelModelDetail = result
                    self.delegate?.marvelDetailResponse()
                }
                catch {
                    print(response.error.debugDescription as Any)
                    self.delegate?.marvelDetailResponse()
                }
            }
            else {
                print(response.error.debugDescription)
                self.delegate?.marvelDetailResponse()
            }
        }
    }
}
