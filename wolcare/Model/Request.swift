//
//  WorkShop.swift
//  wolcare
//
//  Created by Arnaud Salomon on 10/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class Request: CustomStringConvertible {
 
    
    var _id: String?
    var idCategory: String?
    var idUser: String?
    var psuedoUser: String?
    var idVolunteer: String?
    var photoPath: String?
    var title: String?
    var Requestdescription: String?
    var status: Int?
    var createAt: String?

    
    init(idCategory: String?, idUser: String?, psuedoUser: String?, idVolunteer: String?, photoPath: String?, title: String?, Requestdescription: String?, status: Int?, createAt: String?) {
        
        
        self.idCategory = idCategory
        self.idUser = idUser
        self.psuedoUser = psuedoUser
        self.idVolunteer = idVolunteer
        self.photoPath = photoPath
        self.title = title
        self.Requestdescription = Requestdescription
        self.status = status
        self.createAt = createAt
        
        
   
    }
    
    convenience init(_id: String?,idCategory: String?, idUser: String?, psuedoUser: String?, idVolunteer: String?, photoPath: String?, title: String?, Requestdescription: String?, status: Int?, createAt: String?) {
        self.init(idCategory: idCategory, idUser: idUser, psuedoUser: psuedoUser, idVolunteer: idVolunteer, photoPath: photoPath, title: title, Requestdescription: Requestdescription, status: status, createAt: createAt)
         self._id = _id
         self.idCategory = idCategory
         self.idUser = idUser
         self.psuedoUser = psuedoUser
         self.idVolunteer = idVolunteer
         self.photoPath = photoPath
         self.title = title
         self.Requestdescription = Requestdescription
         self.status = status
         self.createAt = createAt
         
    
     }
    
 
    
    var description: String {
    return "{ idCategory: \(self.idCategory ), idUser: \(self.idUser), psuedoUser: \(self.psuedoUser), idVolunteer: \(self.idVolunteer), photoPath: \(self.photoPath), title: \(self.title), Requestdescription: \(self.Requestdescription), status: \(self.status) createAt: \(self.createAt) }"
    }
}
