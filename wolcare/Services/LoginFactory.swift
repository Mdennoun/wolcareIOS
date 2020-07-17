//
//  LoginFactory.swift
//  wolcare
//
//  Created by Mohamed dennoun on 07/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class LoginFactory: CustomStringConvertible {
     
        
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
        
    var description: String {
        return "{ Mail: \(self.email ), Password: \(self.password) }"
    }
    
    
    static func userFrom(dictionary: [String: Any]) -> User? {
           guard let email = dictionary["email"] as? String,
                 let password = dictionary["password"] as? String
        else {
                   return nil
           }
        let user = User(email: email, password: password)
           return user
       }
       
       static func dictionaryFrom(user: User) -> [String: Any] {
           return [
               "type": "IOS",
               //"email": user.email,
               //"password": user.password,
               "password": "test1",
               "email":"test1@test.fr"
           ]
       }
    
}
