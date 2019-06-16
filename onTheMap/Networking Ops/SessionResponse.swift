//
//  SessionResponse.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/12/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let session: Session
    let account: Account
}
