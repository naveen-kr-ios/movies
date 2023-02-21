//
//  APIRouter.swift
//  Movies
//
//  Created by Naveen Kumar V on 19/02/23.
//

import Foundation
import Alamofire

typealias DictionaryTypeAny = [String: Any]

enum APIRouter: URLRequestConvertible {
    
    case movieList(pageNo: Int)
           
    var method: HTTPMethod {
        switch self {
        case .movieList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .movieList:
            return Constants.topRated
        }
    }
    
    var queryParams: DictionaryTypeAny? {
        switch self {
        case .movieList(let pageNo):
            var params = DictionaryTypeAny()
            params[Constants.api_key] = Constants.apiKey
            params[Constants.page] = pageNo
            return params
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: Constants.baseURLString)
        url = url.flatMap{ URL(string: $0.absoluteString + path) }
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        return try URLEncoding.default.encode(urlRequest, with: queryParams)
    }
}
