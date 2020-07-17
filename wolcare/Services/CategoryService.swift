//
//  CategoryService.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 15/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import Foundation

typealias CategoryCompletion = ([CategoryModel]) -> Void

class CategoryService {
    
   func getCategorys(completion: @escaping CategoryCompletion) -> Void {
           guard let userUrl = URL(string: "https://wolcare.herokuapp.com/api/getCategorys") else {
               return;
           }
           let task = URLSession.shared.dataTask(with: userUrl) { (data,res,err) in

               guard let bytes = data,
               err == nil,
               let  json = try? JSONSerialization.jsonObject(with: bytes, options: .allowFragments) as? [Any] else {
                   DispatchQueue.main.sync {
                       completion([])
                   }
                       return
               }
               print(json)
               print("help")
               let category =  json.compactMap { (obj) -> CategoryModel? in
                   guard let category = obj as? [String: Any] else {
                       return nil
                   }
                   return CategoryFactory.CategoryFrom(category: category)
               }
               DispatchQueue.main.sync {
                   completion(category)
               }
               print(category)
           }
           task.resume()
           
       }

}
 


