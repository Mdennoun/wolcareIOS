//
//  Category.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 15/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

class CategoryModel:  CustomStringConvertible {
  
    
    var _id: String?
    var categoryName: String?
    
    
    
    init(categoryName: String?) {
        self.categoryName = categoryName
    }
    
    convenience init (_id: String?,categoryName: String?) {
        self.init(categoryName: categoryName)
        self._id = _id
        self.categoryName = categoryName
    }
    
    var description: String {
        return "{ _id: \(self._id ), categoryName: \(self.categoryName)}"
    }
}
