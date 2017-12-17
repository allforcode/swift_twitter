//
//  Tweet.swift
//  twitter
//
//  Created by Paul Dong on 17/12/17.
//  Copyright © 2017 Paul Dong. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

struct Tweet: JSONDecodable {
    let user: User
    let messageText: String
    
    init(json: JSON) {
        self.user = User(json: json["user"])
        self.messageText = json["message"].stringValue
    }
}
