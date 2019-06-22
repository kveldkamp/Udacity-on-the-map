//
//  PostLocationRequest.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/22/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation

struct PostLocationRequest: Codable{
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    
    init(dictionary: [String : Any]){
        firstName = dictionary["firstName"] as! String
        lastName = dictionary["lastName"] as! String
        longitude = dictionary["longitude"] as! Double
        latitude = dictionary["latitude"] as! Double
        mediaURL = dictionary["mediaURL"] as! String
        mapString = dictionary["mapString"] as! String
        uniqueKey = dictionary["uniqueKey"] as! String
    }
}
