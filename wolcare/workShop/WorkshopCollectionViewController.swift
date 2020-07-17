//
//  WorkshopCollectionViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 11/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class WorkshopCollectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
   
    
    
    @IBOutlet var collectionView: UICollectionView!
    

    let workshopServices: WorkShopService = WorkShopService()
    private var workshops = [WorkShop]()
    var filterTableData = [WorkShop]()
    let filtertableCount = 0;
    var resultSearchController = UISearchController()


    var TableData = [WorkShop]()
    
    
    class func newInstance(workshops: [WorkShop]) -> WorkshopCollectionViewController {
        
        let workshoplvc = WorkshopCollectionViewController()
        workshoplvc.workshops = workshops
        workshoplvc.TableData = workshops
        return workshoplvc
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Ateliers"
        collectionView.delegate = self
        collectionView.dataSource = self
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WorkshopCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_WORKSHOP_IDENTIFER")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        navigationController?.title = "Ateliers"
        setSearchView()
        WorkshopInCollection()
        self.workshopServices.getWorkshop { (workshops) in
            print("eworkji")
            print(workshops)
            print("ere")}
        
        collectionView.reloadData()
    }
    
    func setSearchView() {
        self.resultSearchController = ({
            let controller  = UISearchController(searchResultsController: nil)
            
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.setValue("Retour", forKey: "cancelButtonText")
            controller.searchBar.placeholder = "Chercher"
            controller.definesPresentationContext = false
            controller.obscuresBackgroundDuringPresentation = false
            navigationItem.searchController = controller
            
            return controller
        })()
        setSearchControllerDelegate(viewController: self, navigationItem: navigationItem)
        
        self.collectionView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterTableData.removeAll(keepingCapacity: false)
        let searchWord = searchController.searchBar.text!
        
        for workshop in self.TableData {
            if(workshop.title!.uppercased().contains(searchWord.uppercased())){
                filterTableData.append(workshop)
            }
        }

        self.workshops = self.filterTableData
        if searchWord.count > 0 {
            self.collectionView.reloadData()
        } else {
            self.workshops = self.TableData
        }
       }
    
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.workshops = self.TableData
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        if(self.filterTableData.count == 0) {
            self.workshops = self.TableData
            collectionView.reloadData()
            searchBar.setShowsCancelButton(false, animated: true)
        } else {
            self.workshops = self.filterTableData
            collectionView.reloadData()
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
    }
   
    func WorkshopInCollection() {
        self.workshopServices.getWorkshop { (workshops) in
            self.workshops = workshops
            self.TableData = workshops
            print("hey")
            print(workshops)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("why not")
        WorkshopInCollection()
        setSearchView()
        navigationItem.searchController?.searchBar.isHidden = false
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("count:")
        print(workshops.count)
        return workshops.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_WORKSHOP_IDENTIFER", for: indexPath) as! WorkshopCollectionViewCell
        
        //set swipe for gesture recongnizer
        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(reset) )
        
        //set direction
        UpSwipe.direction = UISwipeGestureRecognizer.Direction.up
        //set geture for cell
        cell.addGestureRecognizer(UpSwipe)
        
        cell.title!.text = workshops[indexPath.row].title
        cell.user!.text = workshops[indexPath.row].idCreator
        cell.user!.textColor = UIColor.white
        cell.user!.backgroundColor = UIColor.darkGray
        
        cell.picture?.image = UIImage(named: "workshop")
        
        
        
        if let imageURL = URL(string: workshops[indexPath.row].photoPath ?? "") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.picture?.image = image
                    }
                }
            }
        }
        return cell
    }

    @objc func addTapped() {
        
        print("add")
        let vc = WorkshopCreateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func reset(sender: UISwipeGestureRecognizer) {
        
        let cell = sender.view as! UICollectionViewCell
            print("tapped rest")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("go to")
        let vc = WorkshopDetailViewController.newInstance(workshop: workshops[indexPath.row])
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


