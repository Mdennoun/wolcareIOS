//
//  CategoryFactory.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 15/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class CategoryFactory: NSObject {
       
    var _id: String?
    var categoryName: String?
    
    
    static func CategoryFrom(category: [String:Any]) -> CategoryModel? {
        guard let id = category["_id"] as? String,
            let categoryName = category["categoryName"] as? String else {
                return nil
        }
        
        
        
        
        return CategoryModel(_id: id, categoryName: categoryName)
    }
    
   
    static func dictionaryFrom(category: CategoryModel) -> [String: Any] {
        return [
            "_id": category._id ?? nil,
            "categoryName": category.categoryName
            
            

        ]
    }

}

