//
//  UserWebService.swift
//  wolcare
//
//  Created by Arnaud Salomon on 10/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

typealias UserCompletion = ([User]) -> Void
typealias userCompletion = (User) -> Void
class UserWebService {
    
    
    
    func newUser(user: User, completion: @escaping (Bool) -> Void) -> Void {
        guard let usertURL = URL(string: "http://localhost:7000/api/newUser") else {
            return
        }
        var request = URLRequest(url: usertURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: UserFactory.dictionaryFrom(user: user), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                print(httpRes.statusCode)
                completion(httpRes.statusCode == 201)
                return
            }
            print("Error \(err.debugDescription)")
            completion(false)
        })
        task.resume()
    }
    
    /*func modifyUser(user: User, completion: @escaping (Bool) -> Void) -> Void {
        guard let usertURL = URL(string: "https://wolcare.herokuapp.com/api/updateUser/\(id)") else {
            return
        }
        var request = URLRequest(url: usertURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: UserFactory.dictionaryFrom(user: user), options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse {
                print(httpRes.statusCode)
                completion(httpRes.statusCode == 201)
                return
            }
            print("Error \(err.debugDescription)")
            completion(false)
        })
        task.resume()
    }*/
    
    func getUsers(completion: @escaping UserCompletion) -> Void {
        guard let userUrl = URL(string: "https://wolcare.herokuapp.com/api/getUsers") else {
            return;
        }
        let task = URLSession.shared.dataTask(with: userUrl) { (data,res,err) in
            guard let bytes = data,
            err == nil,
            let  json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                DispatchQueue.main.sync {
                    completion([])
                }
                    return
            }
            print(json)
            let users =  json.compactMap { (obj) -> User? in
                guard let user = obj as? [String: Any] else {
                    return nil
                }
                return UserFactory.userFrom(user: user)
            }
            DispatchQueue.main.sync {
                completion(users)
            }
            print(users)
        }
        task.resume()
        
        let date = Date()
        let arr = [User(_id: "_id", email: "email", password: "password", type:"type", pseudo : "pseudo", firstname: "firstname", lastname: "lastname", birthdate: date.debugDescription, sex: true, photo: "photo", requestIssued: 0, requestFulfilled: 0 )]
        completion(arr)
    }
    
    func getconnectedUser(completion: @escaping userCompletion) -> Void {
        let url = "https://wolcare.herokuapp.com/api/getUserById/" + connecterUser.id;
        print(url)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //guard let httpBody = try? JSONSerialization.data(withJSONObject:parameters, options: []) else { return }
        //request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            print("got json response dictionary is \n \(json)")
            // update UI using the response here
            let user =  UserFactory.userFrom(user: json)
            
            DispatchQueue.main.sync {
                if(user != nil) {
                    completion(user!)
                }
            }
        }

        // execute the HTTP request
        task.resume()
        
       
    }
    
    func deleteUser(id: String) -> Void {
        
       //let parameters = ["recipeId": id] as [String : String]
        guard let url = URL(string: "https://wolcare.herokuapp.com/api/deleteUserById/\(id)") else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //guard let httpBody = try? JSONSerialization.data(withJSONObject:parameters, options: []) else { return }
        //request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            print("got json response dictionary is \n \(json)")
            
            
            // update UI using the response here
        }

        // execute the HTTP request
        task.resume()
        
        
        
    }
    
    
    func modiUserTEST(id: String) -> Void {
        
       //let parameters = ["recipeId": id] as [String : String]
        guard let url = URL(string: "https://wolcare.herokuapp.com/api/deleteUser/\(id)") else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //guard let httpBody = try? JSONSerialization.data(withJSONObject:parameters, options: []) else { return }
        //request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            print("got json response dictionary is \n \(json)")
            // update UI using the response here
        }

        // execute the HTTP request
        task.resume()
        
        
        
    }
    
}


