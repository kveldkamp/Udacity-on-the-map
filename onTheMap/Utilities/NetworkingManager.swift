//
//  networkingManager.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/11/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import Foundation


class NetworkingManager{
    
    struct SessionInfo{
        static var sessionId = ""
        static var sessionExpiration = ""
        static var accountKey = ""
        static var accountIsRegistered = false
    }
    
    enum Endpoints {
        static let udacityBase = "https://onthemap-api.udacity.com/v1"
        
        case session
        case studentLocation
        case userData
        
        var stringValue: String {
            switch self{
            case .session:
                return Endpoints.udacityBase + "/session"
            
            case .studentLocation:
                return Endpoints.udacityBase + "/StudentLocation"
                
            case .userData:
                return Endpoints.udacityBase + "/users/"
            }
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType:Decodable>(url: URL, response: ResponseType.Type,stupid5CharacterDeleter: Bool, completion: @escaping (ResponseType?,Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            
            var newData : Data
            if stupid5CharacterDeleter{
                let range = 5..<data.count
                newData = data.subdata(in: range)
            }
            else{
                newData = data
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
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
    
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, stupid5CharacterDeleter: Bool, completion: @escaping (ResponseType?, Error?) -> Void){
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
            var newData : Data
            if stupid5CharacterDeleter{
                let range = 5..<data.count
                newData = data.subdata(in: range)
            }
            else{
                newData = data
            }
            
            
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
        taskForPOSTRequest(url: Endpoints.session.url, responseType: SessionResponse.self, body: body, stupid5CharacterDeleter: true){ response, error in
            if let response = response{
                self.SessionInfo.sessionId = response.session.id
                self.SessionInfo.sessionExpiration = response.session.expiration
                self.SessionInfo.accountKey = response.account.key
                self.SessionInfo.accountIsRegistered = response.account.registered
                completion(true,nil)
            }
            else{
                completion(false,error)
            }
        }
    }
    
    class func getStudentsLocations(completion: @escaping ([StudentLocation], Error?) -> Void){
       taskForGETRequest(url: Endpoints.studentLocation.url, response: StudentLocationResponse.self, stupid5CharacterDeleter: false){response, error in
        if let response = response {
                completion(response.results,nil)
        }
        else {
            completion([], error)
        }
    }
    }
    
    class func getUserData(completion: @escaping (Bool, Error?) -> Void){
        var url: URL
        if SessionInfo.accountKey != ""{
            let urlString = Endpoints.userData.stringValue + "\(self.SessionInfo.accountKey)"
            url = URL(string: urlString)!
             taskForGETRequest(url: url, response: UserDataResponse.self, stupid5CharacterDeleter: true){response, error in
                if let response = response {
                    UserInfo.firstName = response.firstName
                    UserInfo.lastName = response.lastName
                    completion(true,nil)
                }
                else {
                    completion(false, error)
                }
            }
        }
    }
    
    
    
    
    }

