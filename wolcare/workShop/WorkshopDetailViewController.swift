//
//  RequestDetailViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 02/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class WorkshopDetailViewController: UIViewController {

    @IBOutlet var creatorPseudo: UILabel!
    @IBOutlet var creationDate: UILabel!
    @IBOutlet var requestDescription: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var Gotomessage: UIButton!
    var currentWorshop: WorkShop!
    let workshopServices: WorkShopService = WorkShopService()
    
    
    class func newInstance(workshop: WorkShop) -> WorkshopDetailViewController {
        
        let vc = WorkshopDetailViewController()
        vc.currentWorshop = workshop
        vc.navigationItem.title = workshop.title!
            
        
        
        if let imageURL = URL(string: workshop.photoPath!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        vc.picture?.image = image
                        vc.creatorPseudo?.text = workshop
                            .idCreator!
                        vc.creationDate?.text = workshop.createAt!
                        vc.requestDescription?.text = workshop.WorkshopDescription!
                    }
                }
                DispatchQueue.main.async {
                    if (vc.picture.image == nil){
                        
                        vc.picture?.image = UIImage(named: "workshop")
                        vc.creatorPseudo?.text = workshop.idCreator!
                        vc.creationDate?.text = workshop.createAt!
                        vc.requestDescription?.text = workshop.WorkshopDescription!
                    }
                }
            }
        }
        return vc
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(connecterUser.id == currentWorshop.idCreator) {
                   self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
                   self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
               }
        // Do any additional setup after loading the view.
    }
    @IBAction func Gotomessage(_ sender: Any) {
        let msgController =  MessageTableViewController.newInstance(request: nil, workshop: currentWorshop)
        self.navigationController?.pushViewController(msgController, animated: true)
        
        
        
    }
    @objc func deleteTapped() {
    
       /* let actionYes : [String: () -> Void] = [ "OUI" : { (
            print("tapped YES")
            
            
        )
            print("tapped YES i tried")
            self.requestServices.deleteRequest(id: self.currentRequest._id!)
            
            let actionOk: () -> Void = { (
                print("tapped OK")
            ) }
            self.showCustomAlertWith(
            okButtonAction: actionOk, // This is optional
            message: "La requete a bien été supprimé !",
            descMsg: "",
            itemimage: nil,
            actions: nil)
            }]
        let actionNo : [String: () -> Void] = [ "NON" : { (
            print("tapped NO")
        ) }]
        let arrayActions = [actionYes, actionNo]
        
        
        self.showCustomAlertWith(
            message: "Êtes-vous sur de vouloir supprimer la recette ?",
            descMsg: "Attention: toutes la photo liée à la requete sera supprimé.",
            itemimage: nil,
            actions: arrayActions)
        
        
        
        */
          
         
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
