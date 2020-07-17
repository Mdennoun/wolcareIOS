//
//  LoginService.swift
//  wolcare
//
//  Created by Mohamed dennoun on 07/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class LoginService {
    
    func login(user: User, completion: @escaping (Bool) -> Void) -> Void {
           guard let scooterURL = URL(string: "https://wolcare.herokuapp.com/api/auth/login") else {
               return
           }
           var request = URLRequest(url: scooterURL)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: LoginFactory.dictionaryFrom(user: user), options: .fragmentsAllowed)
           request.setValue("application/json", forHTTPHeaderField: "content-type")
           let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
               if let httpRes = res as? HTTPURLResponse {
                
                completion(httpRes.statusCode == 200)
               }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("data: \(dataString)")
                let dict = dataString.toJSON() as? [String:AnyObject]
               

                let id = (dict?["idUser"] as AnyObject? as? String) ?? "test"
                print(id)

                        
                
                connecterUser.id = id
                    completion(true)
            } else {

                completion(false)
            }
            
           })
        
           task.resume()
       }

}
 

struct Userdata: Decodable {
    let idUser: String
    let auth: String
    let platform: String?
    let token: String?
}
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
