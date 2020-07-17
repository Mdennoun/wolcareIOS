//
//  WorkShop.swift
//  wolcare
//
//  Created by Arnaud Salomon on 10/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class WorkShop: CustomStringConvertible {
    
    
    var id: String?
    var idCategory: String?
    var idCreator: String?
    var idIntervenant: String?
    var title : String?
    var maxPeoplesAllowed: Int?
    var status: Int?
    var dateAvailable: String?
    var createAt: String?
    var datEnd: String?
    var photoPath: String?
    var WorkshopDescription: String?
    
    

    
    init(idCategory: String?, idCreator: String?, idIntervenant: String?, title : String?, maxPeoplesAllowed: Int?, status: Int?, dateAvailable: String?, createAt: String? , datEnd: String?, photoPath: String?, WorkshopDescription: String?) {
   
        
        self.idCategory = idCategory
        self.idCreator = idCreator
        self.idIntervenant = idIntervenant
        self.title = title
        self.maxPeoplesAllowed = maxPeoplesAllowed
        self.status = status
        self.dateAvailable = dateAvailable
        self.createAt = createAt
        self.photoPath = photoPath
        self.datEnd = datEnd
        self.WorkshopDescription = WorkshopDescription
    
        
        
   
    } 
    
    
    convenience init (id: String?, idCategory: String?, idCreator: String?, idIntervenant: String?, title : String?, maxPeoplesAllowed: Int?, status: Int?, dateAvailable: String?, createAt: String? , datEnd: String?, photoPath: String?, WorkshopDescription: String?) {
        self.init(idCategory: idCategory, idCreator: idCategory, idIntervenant: idCategory, title : title, maxPeoplesAllowed: maxPeoplesAllowed, status: status, dateAvailable: dateAvailable, createAt: createAt, datEnd: datEnd, photoPath: photoPath, WorkshopDescription: WorkshopDescription)
        
         self.id = id
         self.idCategory = idCategory
         self.idCreator = idCreator
         self.idIntervenant = idIntervenant
         self.title = title
         self.maxPeoplesAllowed = maxPeoplesAllowed
         self.status = status
         self.dateAvailable = dateAvailable
         self.createAt = createAt
         self.datEnd = datEnd
         self.photoPath = photoPath
         self.WorkshopDescription = WorkshopDescription
         
    
     }
    
    var description: String {
    return "{ _id: \(self.id ), idCategory: \(self.idCategory ), idCreator: \(self.idCreator ), idIntervenant: \(self.idIntervenant ), title: \(self.title ), maxPeoplesAllowed: \(self.maxPeoplesAllowed ), status: \(self.status ), dateAvailable: \(self.dateAvailable ), createAt: \(self.createAt ), photoPath: \(self.photoPath), description: \(self.WorkshopDescription ) }"
    }
}
