//
//  WorkShopService.swift
//  wolcare
//
//  Created by Arnaud Salomon on 12/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

typealias WorkShopCompletion = ([WorkShop]) -> Void

class WorkShopService {
    
    func getWorkshop(completion: @escaping WorkShopCompletion) -> Void {
        guard let userUrl = URL(string: "https://wolcare.herokuapp.com/api/getWorkShops") else {
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
            
            print("help")
            print(json)
            
            let workshop =  json.compactMap { (obj) -> WorkShop? in
                guard let workshop = obj as? [String: Any] else {
                    return nil
                }
                return WorkShopFactory.workShopFrom(workShop: workshop)
            }
            DispatchQueue.main.sync {
                completion(workshop)
            }
            print(workshop)
        }
        task.resume()
        
    }
    
    func neWorkShop(workShop: WorkShop, completion: @escaping (Bool) -> Void) -> Void {
        guard let workShopURL = URL(string: "http://localhost:7000/api/newWorkShop") else {
            return 
        }
        var request = URLRequest(url: workShopURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: WorkShopFactory.dictionaryFrom(workShop: workShop), options: .fragmentsAllowed)
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
    
    func getWorkShop(completion: @escaping WorkShopCompletion) -> Void {
        guard let userUrl = URL(string: "https://wolcare.herokuapp.com/api/getWorkShops") else {
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
            let workShop =  json.compactMap { (obj) -> WorkShop? in
                guard let workShop = obj as? [String: Any] else {
                    return nil
                }
                return WorkShopFactory.workShopFrom(workShop: workShop)
            }
            DispatchQueue.main.sync {
                completion(workShop)
            }
            print(workShop)
        }
        task.resume()
        
        /*
        let arr = [WorkShop(_id: "_id", idCreator: "idCreator", idIntervenant: "idIntervenant", title:"title", workShopDescription: "description", dateAvailable: Date(), datEnd: Date(), category: "cateogry", status: 0, createAt: Date())]
        completion(arr)*/
    }
    
 
    
    
    func deleteWorkShop(id: String) -> Void {
        
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
    func updateWorkshop(workshop: WorkShop, completion: @escaping (Bool) -> Void) -> Void {
        guard let scooterURL = URL(string: "https://wolcare.herokuapp.com/api/updateWorkShop/\(workshop.id)") else {
                   return
               }
               var request = URLRequest(url: scooterURL)
               request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: WorkShopFactory.dictionaryFrom(workShop: workshop), options: .fragmentsAllowed)
               request.setValue("application/json", forHTTPHeaderField: "content-type")
               let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
                   if let httpRes = res as? HTTPURLResponse {
                    
                    completion(httpRes.statusCode == 200)
                   }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    
                        completion(true)
                } else {

                    completion(false)
                }
                
               })
            
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



