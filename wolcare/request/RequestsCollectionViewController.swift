//
//  RequestsCollectionViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 02/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class RequestsCollectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
   
    
    
    @IBOutlet var collectionView: UICollectionView!
    

    let requestServices: RequestService = RequestService()
    private var requests = [Request]()
    var filterTableData = [Request]()
    let filtertableCount = 0;
    var resultSearchController = UISearchController()


    var TableData = [Request]()
    
    
    class func newInstance(requests: [Request]) -> RequestsCollectionViewController {
        
        let requestlvc = RequestsCollectionViewController()
        requestlvc.requests = requests
        requestlvc.TableData = requests
        return requestlvc
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Requetes"
        collectionView.delegate = self
        collectionView.dataSource = self
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "RequestCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_IDENTIFER")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
       
        navigationController?.title = "Requetes"
        setSearchView()
        
       
        
        
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
        
        for request in self.TableData {
            if(request.title!.uppercased().contains(searchWord.uppercased())){
                filterTableData.append(request)
            }
        }

        self.requests = self.filterTableData
        if searchWord.count > 0 {
            self.collectionView.reloadData()
        } else {
            self.requests = self.TableData
        }
       }
    
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.requests = self.TableData
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        if(self.filterTableData.count == 0) {
            self.requests = self.TableData
            collectionView.reloadData()
            searchBar.setShowsCancelButton(false, animated: true)
        } else {
            self.requests = self.filterTableData
            collectionView.reloadData()
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
    }
   
    func RequestInCollection() {
        self.requestServices.getRequest { (requests) in
            self.requests = requests
            self.TableData = requests
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("why not")
        RequestInCollection()
        setSearchView()
        navigationItem.searchController?.searchBar.isHidden = false
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return requests.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_IDENTIFER", for: indexPath) as! RequestCollectionViewCell
        
        
        //set swipe for gesture recongnizer
        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(reset) )
        
        //set direction
        UpSwipe.direction = UISwipeGestureRecognizer.Direction.up
        //set geture for cell
        cell.addGestureRecognizer(UpSwipe)
        
        cell.title!.text = requests[indexPath.row].title
        cell.user!.text = requests[indexPath.row].psuedoUser
        cell.user!.textColor = UIColor.white
        cell.user!.backgroundColor = UIColor.darkGray
        
        cell.picture?.image = UIImage(named: "workshop")
        
        
        
        if let imageURL = URL(string: requests[indexPath.row].photoPath!) {
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
        let vc = RequestCreateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func LogoutTapped() {
        
        print("logout")
        let vc = LoginViewController()
        self.navigationController?.popToRootViewController(animated: true)
           
       }
    
    @objc func reset(sender: UISwipeGestureRecognizer) {
        
        let cell = sender.view as! UICollectionViewCell
            print("tapped rest")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("go to")
        let vc = RequestDetailViewController.newInstance(request: requests[indexPath.row])
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension UIViewController : UISearchBarDelegate {
    

    func makeBlackNavigationbar (viewController: UIViewController, animated: Bool) {

        viewController.navigationController?.navigationBar.backgroundColor? = UIColor.black

           let searchBar = UISearchBar()
            searchBar.placeholder = "Chercher"
            searchBar.delegate = viewController
            viewController.navigationItem.titleView = searchBar
    }}
    
    func setSearchControllerDelegate(viewController: UIViewController, navigationItem : UINavigationItem)
    {
        
        navigationItem.searchController!.searchBar.delegate = viewController
        
    }
