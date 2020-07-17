//
//  RequestService.swift
//  wolcare
//
//  Created by Mohamed dennoun on 02/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

typealias RequestCompletion = ([Request]) -> Void

class RequestService {
    
    
    
    func newRequest(request: Request, photo : Data?, completion: @escaping (Bool) -> Void) -> Void {
        guard let requestURL = URL(string: "https://wolcare.herokuapp.com/api/newRequest") else {
            return //https://wolcare.herokuapp.com/api/newRequest
        }
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: RequestFactory.dictionaryFrom(request: request), options: .fragmentsAllowed)
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, res, err) in
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
    
    
    func getRequest(completion: @escaping RequestCompletion) -> Void {
        guard let userUrl = URL(string: "https://wolcare.herokuapp.com/api/getRequests") else {
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
            print("help")
            let request =  json.compactMap { (obj) -> Request? in
                guard let request = obj as? [String: Any] else {
                    return nil
                }
                return RequestFactory.RequestFrom(request: request)
            }
            DispatchQueue.main.sync {
                completion(request)
            }
            print(request)
        }
        task.resume()
        
    }
    
 
    
    
    func deleteRequest(id: String) -> Void {
        
       //let parameters = ["recipeId": id] as [String : String]
        guard let url = URL(string: "https://wolcare.herokuapp.com/api/deleteRequestById/\(id)") else { return }
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
    
    
    func FeatchRequest(id: String) -> Void {
        
       //let parameters = ["recipeId": id] as [String : String]
        guard let url = URL(string: "https://wolcare.herokuapp.com/api/featchRequest/\(id)") else { return }
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




