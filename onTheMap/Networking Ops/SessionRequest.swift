//
//  SessionRequest.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/16/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation

struct SessionRequest: Codable {
    let udacity: LoginInfo
}


struct LoginInfo: Codable{
    let username: String
    let password: String
}
