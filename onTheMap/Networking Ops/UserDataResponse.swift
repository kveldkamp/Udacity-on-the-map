//
//  UserDataResponse.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/22/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation

struct UserDataResponse: Codable{
    let lastName: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}


