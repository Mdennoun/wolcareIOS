//
//  MessageServices.swift
//  wolcare
//
//  Created by Mohamed dennoun on 07/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation
import Alamofire


typealias MessageCompletion = ([Message]) -> Void

class MessageServices {
    
    
    
    func newMessage(message: Message, vocalMessage : Data?, completion: @escaping (Bool) -> Void) -> Void {
        guard let requestURL = URL(string: "https://wolcare.herokuapp.com/api/newMessage") else {
            return
        }
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: MessageFactory.dictionaryFrom(message: message), options: .fragmentsAllowed)
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
    
    
    func getMessage(completion: @escaping MessageCompletion) -> Void {
        guard let userUrl = URL(string: "https://wolcare.herokuapp.com/api/getMessages") else {
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
            let message =  json.compactMap { (obj) -> Message? in
                guard let message = obj as? [String: Any] else {
                    return nil
                }
                return MessageFactory.MessageFrom(message: message)
            }
            DispatchQueue.main.sync {
                completion(message)
            }
            print(message)
        }
        task.resume()
        
    }
    func getMessageByIDS(idRequest: String, idSender: String, idReceiver: String,completion: @escaping MessageCompletion) -> Void {
    
        let url = "https://wolcare.herokuapp.com/api/getMessageByIDS"
       
        let parameter: [String: String] = [
            "idRequest" : idRequest,
            "idSender" : idSender,
            "idReceiver" : idReceiver
        ]
        
        var request = URLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)

        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
       
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);


        AF.request(request as URLRequestConvertible)
            .responseJSON { response in
                
          switch response.result {
          case .success(let value):
            if let dictionary = value as? [[String: Any]]{

                let message =  dictionary.compactMap { (obj) -> Message? in
                    guard let message = obj as? [String: Any] else {
                        return nil
                    }
                    return MessageFactory.MessageFrom(message: message)
                }
                completion(message)
                }
            break
            
          //success, do anything
          case .failure(let error):
            print(error.localizedDescription)
            completion([])
            break
          //failure
          }
              

        
    }
    
    }
    func saveMsg(message: Message,completion: @escaping (Bool) -> Void) -> Void {
    
        let url = "http://localhost:6000/api/newMessage"
       
     
        var request = URLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONSerialization.data(withJSONObject: MessageFactory.dictionaryFrom(message: message), options: JSONSerialization.WritingOptions.prettyPrinted)

        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
       
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);


        AF.request(request as URLRequestConvertible)
            .responseJSON { response in
                
          switch response.result {
          case .success(let value):
            if let dictionary = value as? [String: Any]{

                let message =  dictionary.compactMap { (obj) -> Message? in
                    guard let message = obj as? [String: Any] else {
                        return nil
                    }
                    return MessageFactory.MessageFrom(message: message)
                }
                completion(message != nil)
                }
            break
            
          //success, do anything
          case .failure(let error):
            print(error.localizedDescription)
            completion(false)
            break
          //failure
          }
              

        
    }
    
    }
    
    
}
