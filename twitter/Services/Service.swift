//
//  Service.swift
//  twitter
//
//  Created by Paul Dong on 17/12/17.
//  Copyright © 2017 Paul Dong. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    static let sharedInstance = Service()
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("Error when retrieving Json")
        }
    }
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource?, Error?) -> ()) {
        let request: APIRequest<HomeDatasource,JSONError> = tron.request("/twitter/home")
        request.perform(withSuccess: { (homeDatasource) in
            completion(homeDatasource, nil)
        }) { (err) in
            completion(nil, err)
        }
    }
}
