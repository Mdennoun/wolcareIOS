//
//  RequestCreateViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 03/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import Alamofire

class RequestCreateViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var libraryButton: UIButton!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleRequest: UITextField!
    @IBOutlet var requestDescription: UITextField!
    @IBOutlet weak var pseudo: UITextField!
    @IBOutlet var spener: UIActivityIndicatorView!
    
    @IBOutlet weak var categorieEdt: UITextField!
    
    let requestServices: RequestService = RequestService()
    
    override func viewWillAppear(_ animated: Bool) {
        var timerTest : Timer?
            categorie.vc = "request"
             if(categorie.vc == "request") {

                     timerTest =  Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.updateVar), userInfo: nil,  repeats: true)
            } else {
                timerTest!.invalidate()
            }
        
    }

                  
        @objc func updateVar() {
            
            categorieEdt.text = categorie.value
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Nouvelle demande"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(validateTapped))
        
        navigationController?.title = "Nouvelle demande"
        categorieEdt.addTarget(self, action: #selector(self.categoryBiganChanged(_:)), for: .allTouchEvents)
        
        categorieEdt.text = categorie.value
    
    }
    @objc func categoryBiganChanged(_ textField: UITextField){

        let vc = CategorysViewController.newInstance(vcname: "request")
         vc.modalPresentationStyle = .custom
         present(vc, animated: true, completion: nil)
      }
    @objc func validateTapped() {
        
        print("save")
        mainImageView.isHidden = true
        requestDescription.isHidden = true
        titleRequest.isHidden = true
        cameraButton.isHidden = true
        libraryButton.isHidden = true
        pseudo.isHidden = true
        categorieEdt.isHidden = true
        self.spener.isHidden = false
        spener.startAnimating()
        
        
        var request = Request(idCategory: categorie.id, idUser: connecterUser.id, psuedoUser: pseudo.text, idVolunteer: connecterUser.id, photoPath: "photoPath", title: requestDescription.text, Requestdescription: titleRequest.text, status: 0, createAt: Date().description)
        
        print(mainImageView.image?.pngData())
        Post(image : mainImageView.image, request: request)
        
    }
    // MARK: IBAction Methods
    
    @IBAction func camera(sender: Any?) {
        presentUIImagePicker(sourceType: .camera)
    }
    
    @IBAction func library(sender: Any?) {
        presentUIImagePicker(sourceType: .photoLibrary)
    }
    
    // MARK: Helper Methods

    private func presentUIImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }
}

// MARK: UIImagePickerControllerDelegate and UINavigationControllerDelegate

extension RequestCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
            dismiss(animated: true, completion: nil)
            
            return
        }
        mainImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    func Post(image : UIImage?, request: Request){
        print(request)
        let parameters = [
            "idCategory" : request.idCategory!,
            "idUser": request.idUser!,
            "psuedoUser": request.psuedoUser!,
            "idVolunteer": request.idVolunteer!,
            "title" : request.title!,
            "description": request.Requestdescription!,
            "status" : request.status?.description]

        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "application/json"
        ]
        
        


            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(image!.jpegData(compressionQuality: 0.3)!, withName: "photo" , fileName: "file.jpeg", mimeType: "image/jpeg")
                    for (key, value) in parameters {
                        if let temp = value as? String {
                            multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                        }
                    }
            },
                to: "https://wolcare.herokuapp.com/api/newRequest", method: .post , headers: headers)
                .response { resp in
                    
                    self.requestServices.getRequest { (requests) in

                    self.mainImageView.isHidden = false
                    self.requestDescription.isHidden = false
                    self.titleRequest.isHidden = false
                    self.cameraButton.isHidden = false
                    self.libraryButton.isHidden = false
                    self.pseudo.isHidden = true
                    self.categorieEdt.isHidden = true
                    self.spener.isHidden = true
                    self.spener.stopAnimating()
                    let requestController =  RequestsCollectionViewController.newInstance(requests: requests)
                        
                        self.navigationController?.pushViewController(requestController, animated: true)
                        
                        print(resp)
                        
                    }

            }
    }
   
}
