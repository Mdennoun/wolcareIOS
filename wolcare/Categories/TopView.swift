//
//  TopView.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 16/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import Foundation

class TopView : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            
            print("come on")
            print(self.categorys.count)
     
        return categorys.count;
    }
    

    let categoryServices: CategoryService = CategoryService()
    public var categorys = [CategoryModel]()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: bundle)
        cv.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_CATEGORY_IDENTIFER")
        if let flowLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
       
        return cv
    }()
    func CategoryInCollection() {
           self.categoryServices.getCategorys { (categorys) in
               self.categorys = categorys
             print(categorys)
               
           }
       }


      class func newInstance(categorys: [CategoryModel]) -> TopView {
          
        let vc = TopView()
        vc.categorys = categorys
        return vc
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        CategoryInCollection()
        self.backgroundColor = .red

        addSubview(collectionView)

        //Add constraint
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CategoryInCollection()
    }

    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_CATEGORY_IDENTIFER", for: indexPath) as! CategoryCollectionViewCell
                      
                   
        print( categorys[indexPath.row].categoryName)
        cell.title!.text = categorys[indexPath.row].categoryName
        cell.title.backgroundColor = UIColor.red
        cell.picture?.image = UIImage(named: "workshop")
                      
                      
                     
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("go to")
        categorie.value = categorys[indexPath.row].categoryName!
        categorie.id = categorys[indexPath.row]._id!
        categorie.isHidden = true
        print(categorie.value)
       
        self.isHidden = true
        
 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
         let width  = (self.frame.width-20)/3
              return CGSize(width: width, height: width)
        }
}
