//
//  JsonParser.swift
//  Movies
//
//  Created by Naveen Kumar V on 20/02/23.
//

import Foundation

class JsonParser {
    
    typealias Result<T> = (T?, Error?) -> Void
    
    func parse<T: Decodable>(of type: T.Type, from data: Data, completion: @escaping Result<T>) {
        do {
            let decodedData: T = try JSONDecoder().decode(T.self, from: data)
            completion(decodedData, nil)
        }
        catch let error {
            // Json parse error
            completion(nil, error)
        }
    }
}
