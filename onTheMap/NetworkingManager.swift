//
//  networkingManager.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/11/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation


class NetworkingManager{
    
    struct auth{
        var sessionId: String
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case session
        
        var StringValue: String {
            switch self{
            case .session:
                return Endpoints.base + "/session"
            }
        }
    }
    
    
    class func postASession(username: String, password: String, completionHandler: @escaping (SessionResponse?, Error?) -> Void){
        var request = URLRequest(url: URL(string: Endpoints.session.StringValue)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
