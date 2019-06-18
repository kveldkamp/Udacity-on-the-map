//
//  networkingManager.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/11/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation


class NetworkingManager{
    
    struct UserInfo{
        static var sessionId = ""
        static var sessionExpiration = ""
        static var accountKey = ""
        static var accountIsRegistered = false
    }
    
    enum Endpoints {
        static let udacityBase = "https://onthemap-api.udacity.com/v1"
        
        case session
        case studentLocation
        
        var stringValue: String {
            switch self{
            case .session:
                return Endpoints.udacityBase + "/session"
            
            case .studentLocation:
                return Endpoints.udacityBase + "/StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType:Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?,Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode != 200{
                    completion(nil,error)
                    return
                }
            }
            
            //removing first 5 characters
                let range = 5..<data.count
                let newData = data.subdata(in: range)
            
            
            //decoding
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                print("error decoding response")
            }
        }
        task.resume()
    }
    
    
    
    class func postASession(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        let body = SessionRequest(udacity: LoginInfo(username: username,password: password))
        taskForPOSTRequest(url: Endpoints.session.url, responseType: SessionResponse.self, body: body){ response, error in
            if let response = response{
                self.UserInfo.sessionId = response.session.id
                self.UserInfo.sessionExpiration = response.session.expiration
                self.UserInfo.accountKey = response.account.key
                self.UserInfo.accountIsRegistered = response.account.registered
                completion(true,nil)
            }
            else{
                completion(false,error)
            }
        }
    }
    
    class func getStudentsLocations(completion: @escaping ([StudentLocation], Error?) -> Void){
       taskForGETRequest(url: Endpoints.studentLocation.url, response: StudentLocationResponse.self){response, error in
        if let response = response {
            completion(response.results,nil)
        }
        else {
            completion([], error)
        }
    }
    }
    
    
    
    }

