//
//  RequestFactory.swift
//  wolcare
//
//  Created by Mohamed dennoun on 02/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class RequestFactory {
       
       var idCategory: String?
       var idUser: String?
       var psuedoUser: String?
       var idVolunteer: String?
       var photoPath: String?
       var title: String?
       var Requestdescription: String?
       var status: Int?
       var createAt: String?
    
    
    static func RequestFrom(request: [String:Any]) -> Request? {
        guard let id = request["_id"] as? String,
            let idCategory = request["idCategory"] as? String,
            let idUser = request["idUser"] as? String,
            let psuedoUser = request["psuedoUser"] as? String,
            let idVolunteer = request["idVolunteer"] as? String,
            let photoPath = request["photoPath"] as? String,
            let title = request["title"] as? String,
            let Requestdescription = request["description"] as? String,
            let status = request["status"] as? Int,
            let createAt = request["createAt"] as? String else {
                return nil
        }
        
        
        
        
        return Request(_id: id, idCategory: idCategory, idUser: idUser, psuedoUser: psuedoUser, idVolunteer: idVolunteer, photoPath: photoPath, title: title, Requestdescription: Requestdescription, status: status, createAt: createAt)
    }
    
   
    static func dictionaryFrom(request: Request) -> [String: Any] {
        return [
            "idCategory": request.idCategory ?? nil,
            "idUser": request.idUser,
            "psuedoUser": request.psuedoUser ?? "psuedo",
            "idVolunteer": request.idVolunteer ?? nil,
            "title": request.title ?? "default_Title",
            "description": request.Requestdescription ?? "defaultdescription",
            "status": request.status ?? 0,
            "photoPath": request.photoPath ,
            "createAt": request.createAt ?? "createAt"
            
            

        ]
    }

}

