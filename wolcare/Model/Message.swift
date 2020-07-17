//
//  Message.swift
//  wolcare
//
//  Created by Mohamed dennoun on 06/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation
class Messages: Codable {
    
    let messages : [Message]
    init(messages: [Message]) {
        self.messages = messages
        
    }
    
    
}
class Message: CustomStringConvertible,Codable {
 
    
    var _id: String?
    var idRequest: String?
    var idSender: String?
    var idReceiver: String?
    var date: String?
    var message: String?

    
    init(idRequest: String?, idSender: String?, idReceiver: String?, date: String?, message: String?) {
        
        
        self.idRequest = idRequest
        self.idSender = idSender
        self.idReceiver = idReceiver
        self.date = date
        self.message = message
    }
    
    convenience init(_id: String?,idRequest: String?, idSender: String?, idReceiver: String?, date: String?, message: String?) {
        self.init(idRequest: idRequest, idSender: idSender, idReceiver: idReceiver, date: date, message: message)
         self._id = _id
         self.idRequest = idRequest
         self.idSender = idSender
         self.idReceiver = idReceiver
         self.date = date
         self.message = message
         
    
     }
    
 
    
    var description: String {
    return "{ _id: \(self._id ), idRequest: \(self.idRequest), idSender: \(self.idSender), idReceiver: \(self.idReceiver), date: \(self.date), message: \(self.message)}"
    }
}
