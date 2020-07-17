//
//  WorkShopFactory.swift
//  wolcare
//
//  Created by Arnaud Salomon on 12/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class WorkShopFactory {
    
    static func workShopFrom(workShop: [String:Any]) -> WorkShop? {
        guard let id = workShop["_id"] as? String,
            let idCategory = workShop["idCategory"] as? String,
            let idIntervenant = workShop["idIntervenant"] as? String,
            let idCreator = workShop["idCreator"] as? String,
            let photoPath = workShop["photoPath"] as? String,
            let title = workShop["title"] as? String,
            let WorkshopDescription = workShop["description"] as? String,
            let dateAvailable = workShop["dateAvailable"] as? String,
            let createAt = workShop["createAt"] as? String,
            let datEnd = workShop["datEnd"] as? String,
            let status = workShop["status"] as? Int,
            let maxPeoplesAllowed = workShop["maxPeoplesAllowed"] as? Int
        else {
                return nil
        }
        
        
        return WorkShop(id: id, idCategory: idCategory, idCreator: idCreator, idIntervenant: idIntervenant, title : title, maxPeoplesAllowed: maxPeoplesAllowed, status: status, dateAvailable: dateAvailable, createAt: createAt , datEnd: datEnd, photoPath: photoPath, WorkshopDescription: WorkshopDescription)
    }
    
   
    static func dictionaryFrom(workShop: WorkShop) -> [String: Any] {
        return [
            
            "_id": workShop.id,
            "idCategory": workShop.idCategory,
            "idCreator": workShop.idCreator,
            "idIntervenant": workShop.idIntervenant,
            "title": workShop.title,
            "maxPeoplesAllowed": workShop.maxPeoplesAllowed,
            "status": workShop.status,
            "dateAvailable": workShop.dateAvailable,
            "datEnd": workShop.datEnd,
            "createAt": workShop.createAt,
            "description": workShop.WorkshopDescription
            

        ]
    }

}
