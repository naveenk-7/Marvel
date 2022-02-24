//
//  APIRouter.swift
//  Marvel
//
//  Created by Naveen Kumar on 22/02/22.
//

import Foundation
import Alamofire
import CryptoKit


typealias DictionaryTypeAny = [String: Any]

enum APIRouter: URLRequestConvertible {
    
    private static let baseURLString = Bundle.main.object(forInfoDictionaryKey: Constants.apiHostURL) as? String
    private static let publicKey =  ProcessInfo.processInfo.environment[Constants.publicKey]
    private static let privateKey = ProcessInfo.processInfo.environment[Constants.privateKey]
    
    case listPage(offset: Int)
    case detailPage(characterID: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .listPage, .detailPage: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .listPage:
            return Constants.characters
        case .detailPage(let characterID):
            return "\(Constants.characters)/\(characterID)"
        }
    }
    
    private var queryParams: DictionaryTypeAny? {
        var params = DictionaryTypeAny()
        params[Constants.apikey] = APIRouter.publicKey
        let ts = Date().timeIntervalSince1970
        params[Constants.hash] = hashValueForTimeStamp(timeStamp: ts)
        params[Constants.ts] = String(ts)
        switch self {
        case .listPage(let offset):
            params[Constants.offset] = offset
            return params
        case .detailPage:
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: APIRouter.baseURLString ?? Constants.empty)
        url?.appendPathComponent(path)
        var urlRequest = URLRequest(url: url ?? URL(fileURLWithPath: Constants.empty))
        urlRequest.httpMethod = method.rawValue
        return try URLEncoding.default.encode(urlRequest, with: queryParams)
    }
    
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: Constants.stringFormat, $0)
        }.joined()
    }
    
    private func hashValueForTimeStamp(timeStamp: TimeInterval) -> String {
        let timeSt = String(timeStamp)
        if let privateKey = APIRouter.privateKey, let publicKey = APIRouter.publicKey {
            let hash = timeSt + privateKey + publicKey
            return MD5(string: hash)
        }
        return Constants.empty
    }

}

