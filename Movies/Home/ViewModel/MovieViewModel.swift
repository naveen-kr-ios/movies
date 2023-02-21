//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Naveen Kumar V on 20/02/23.
//

import Foundation
import Alamofire

class MovieViewModel {
    
    typealias completionHandler = (_ responseData : Any?, _ error : Error?) -> Void
    
    // Movie list API
    func fetchMovieList(completionHandler: @escaping completionHandler) {
        AF.request(APIRouter.movieList(pageNo: 1)).response { response in
            if let data = response.data {
                do {
                    let jsonParser = JsonParser()
                    jsonParser.parse(of: Movie.self, from: data) { result, error in
                        if let _ = error {
                            completionHandler(nil, error)
                        }else{
                            switch response.response?.statusCode{
                            case 200 :
                                completionHandler(result, nil)
                            case 404 :
                                completionHandler(nil, "Page Not Found" as? Error)
                            case 503 :
                                completionHandler(nil, "Service Unavailable" as? Error)
                            default:
                                completionHandler(nil, error)
                            }
                        }
                    }
                }
            }
            else {
                completionHandler(nil, response.error)
            }
        }
    }
    
}

