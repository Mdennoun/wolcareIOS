//
//  MessageFactory.swift
//  wolcare
//
//  Created by Mohamed dennoun on 06/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class MessageFactory {
       
    
       var idRequest: String?
       var idSender: String?
       var idReceiver: String?
       var date: Date?
       var message: String?
       var vocalMSGPath: String?
    
    
    
    static func MessageFrom(message: [String:Any]) -> Message? {
    guard let _id = message["_id"] as? String,
        let idRequest = message["idRequest"] as? String,
        let idSender = message["idSender"] as? String,
        let idReceiver = message["idReceiver"] as? String,
        let date = message["date"] as? String,
        let message = message["message"] as? String else {
            return nil
    }
        
        
        return Message(_id: _id, idRequest: idRequest, idSender: idSender, idReceiver: idReceiver, date: date, message: message)
    }
    
   
    static func dictionaryFrom(message: Message) -> [String: Any] {
        return [
            "idRequest": message.idRequest,
            "idSender": message.idSender,
            "idReceiver": message.idReceiver,
            "date": message.date,
            "message": message.message

        ]
    }
    

}
