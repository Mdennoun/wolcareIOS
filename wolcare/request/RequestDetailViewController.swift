//
//  RequestDetailViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 02/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {

    @IBOutlet var creatorPseudo: UILabel!
    @IBOutlet var creationDate: UILabel!
    @IBOutlet var requestDescription: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var Gotomessage: UIButton!
    var currentRequest: Request!
    let requestServices: RequestService = RequestService()
    
    
    class func newInstance(request: Request) -> RequestDetailViewController {
        
        let requestlvc = RequestDetailViewController()
        requestlvc.currentRequest = request
        requestlvc.navigationItem.title = request.title!
            
        
        
        if let imageURL = URL(string: request.photoPath!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        requestlvc.picture?.image = image
                        requestlvc.creatorPseudo?.text = request.psuedoUser!
                        requestlvc.creationDate?.text = request.createAt!
                        requestlvc.requestDescription?.text = request.Requestdescription!
                    }
                }
                DispatchQueue.main.async {
                    if (requestlvc.picture.image == nil){
                        
                        requestlvc.picture?.image = UIImage(named: "workshop")
                        requestlvc.creatorPseudo?.text = request.psuedoUser!
                        requestlvc.creationDate?.text = request.createAt!
                        requestlvc.requestDescription?.text = request.Requestdescription!
                    }
                }
            }
        }
        return requestlvc
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(connecterUser.id == currentRequest.idUser) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        }
       
        // Do any additional setup after loading the view.
    }
    @IBAction func Gotomessage(_ sender: Any) {
        let msgController = MessageTableViewController.newInstance(request: currentRequest, workshop: nil)
        self.navigationController?.pushViewController(msgController, animated: true)
        
        
        
    }
    @objc func deleteTapped() {
    
        let actionYes : [String: () -> Void] = [ "OUI" : { (
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
