//
//  HomeViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 07/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
  
    let requestServices: RequestService = RequestService()
    let workshopServices: WorkShopService = WorkShopService()
    let userServices = UserWebService();
    var requests:[Request]?
    var workshops:[WorkShop]?
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor(red: 91/255, green: 128/255, blue: 185/255, alpha: 1)
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .red
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "logout"),
            style: .plain,
            target: self,
            action: #selector(LogoutTapped)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
               
        setupTabBar()
 
    }
    @objc func LogoutTapped() {
           
           print("logout")
           let vc = LoginViewController()
           self.navigationController?.popToRootViewController(animated: true)
              
          }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
     func setupTabBar() {
        
        self.requestServices.getRequest { (requests) in
            print("ere")
           // print(requests)
            print("ere")
           
            self.requests = requests
            let requestController = UINavigationController(rootViewController:
                RequestsCollectionViewController.newInstance(requests: requests))
            requestController.tabBarItem.image = UIImage(named: "help_senior_icon")
            requestController.tabBarItem.title = "Requetes"
            
         
           
        self.workshopServices.getWorkshop { (workshops) in
            print("eworkji")
            print(workshops)
            print("ere")
            
           
            
            let workshopController = UINavigationController(rootViewController: WorkshopCollectionViewController.newInstance(workshops: workshops))
            workshopController.tabBarItem.image = UIImage(named: "group_work_icon")
            workshopController.tabBarItem.title = "Ateliers"
            self.userServices.getconnectedUser { (users) in
                      ProfileViewController.self.user = users
                let profileController = UINavigationController(rootViewController: ProfileViewController.newInstance(user: users))
                
                profileController.tabBarItem.image = UIImage(named: "group_work_icon")
                profileController.tabBarItem.title = "Profile"
                self.viewControllers = [requestController, workshopController, profileController]
                  }
            
        }
               }
        
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
