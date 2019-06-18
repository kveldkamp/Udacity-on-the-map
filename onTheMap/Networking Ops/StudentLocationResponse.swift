//
//  StudentLocationResponse.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/16/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation

struct StudentLocationResponse: Codable{
    let results: [StudentLocation]
}


struct StudentLocation: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}
