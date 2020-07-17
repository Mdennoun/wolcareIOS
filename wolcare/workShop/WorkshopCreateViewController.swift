//
//  RequestCreateViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 03/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import Alamofire

class WorkshopCreateViewController: UIViewController {
    func backFromCategory() {
        print("this test not work")
    }
    

    // MARK: Outlets

    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var libraryButton: UIButton!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleRequest: UITextField!
    @IBOutlet var requestDescription: UITextField!
    @IBOutlet var spener: UIActivityIndicatorView!
    @IBOutlet var dateBeginEdt: UITextField!
    @IBOutlet var houtBeginEdt: UITextField!
    @IBOutlet var hourEndEdt: UITextField!
    @IBOutlet weak var categorieEdt: UITextField!
    @IBOutlet weak var maxPeople: UITextField!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    
    let workshopServices: WorkShopService = WorkShopService()
    private var dateBeginPicker: UIDatePicker?
    private var hourBeginPicker: UIDatePicker?
    private var hourEndPicker: UIDatePicker?
    var modalStatus = 0
    
    override func viewWillAppear(_ animated: Bool) {
        spiner.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Nouvel Atelier"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(validateTapped))
        
        navigationController?.title = "Nouvel Atelier"
        dateBeginPicker = UIDatePicker()
        dateBeginPicker?.datePickerMode = .date
        
        hourBeginPicker = UIDatePicker()
        hourBeginPicker?.datePickerMode = .time
        
        hourEndPicker = UIDatePicker()
        hourEndPicker?.datePickerMode = .time
        
        dateBeginPicker?.addTarget(self, action:
            #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        
        hourBeginPicker?.addTarget(self, action:
        #selector(self.hourBeginChanged(datePicker:)), for: .valueChanged)
        
        hourEndPicker?.addTarget(self, action:
        #selector(self.hourEndingChanged(datePicker:)), for: .valueChanged)
        categorieEdt.addTarget(self, action: #selector(self.categoryBiganChanged(_:)), for: .allTouchEvents)
        
        dateBeginEdt.inputView = dateBeginPicker
        hourEndEdt.inputView = hourEndPicker
        houtBeginEdt.inputView = hourBeginPicker
        
        categorie.vc = "workshop"
        var timerTest : Timer?
        if(categorie.vc == "workshop") {

            timerTest = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.updateVar), userInfo: nil,  repeats: true)
            
        } else {
            timerTest!.invalidate()
        }
    
    }

       @objc func updateVar() {
        categorieEdt.text = categorie.value
       }
    
    @objc func validateTapped() {
        
        print("save")
        mainImageView.isHidden = true
        requestDescription.isHidden = true
        titleRequest.isHidden = true
        cameraButton.isHidden = true
        libraryButton.isHidden = true
        dateBeginEdt.isHidden = true
        houtBeginEdt.isHidden = true
        hourEndEdt.isHidden = true
        categorieEdt.isHidden = true
        maxPeople.isHidden = true
        
        
        self.spener.isHidden = false
        spener.startAnimating()
       
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        let dateBegin = "\(dateBeginEdt.text!) \(houtBeginEdt.text!)"
        let datEnding =  "\(dateBeginEdt.text!) \(hourEndEdt.text!)"
        let dateStart = dateFormatter.date(from:dateBegin)!
        let dateEnd = dateFormatter.date(from:datEnding)!
        let date = Date()
        print(dateBegin)
        
        var workshop = WorkShop(idCategory: categorie.id, idCreator: connecterUser.id, idIntervenant: connecterUser.id, title: titleRequest.text, maxPeoplesAllowed: Int(maxPeople.text ?? "3"), status: 0, dateAvailable: dateStart.description, createAt: date.description, datEnd: dateEnd.description, photoPath: "photoPath", WorkshopDescription: requestDescription.text)
        
        print(mainImageView.image?.pngData())
        Post(image : mainImageView.image, workshop: workshop)
        
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
        modalStatus = 1
        present(picker, animated: true, completion: nil)
    }
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
      
        view.endEditing(true)
    }
    
 
                 
    
}

// MARK: UIImagePickerControllerDelegate and UINavigationControllerDelegate

extension WorkshopCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    func Post(image : UIImage?, workshop: WorkShop){
        print(workshop)
        let parameters = WorkShopFactory.dictionaryFrom(workShop: workshop)
        print("Json param")
        print(parameters)
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
                to: "http://localhost:7000/api/addNewWorkshop", method: .post , headers: headers)
                .response { resp in
                    print("here")
                    print(resp.debugDescription)
                    print(resp.data)
                    if let data = resp.data, let dataString = String(data: data, encoding: .utf8) {
                                       
                        print("data: \(dataString)")
                        let dict = dataString.toJSON() as? [String:AnyObject]
                        let id = (dict?["_id"] as AnyObject? as? String) ?? "test"
                        workshop.id = id
                        self.workshopServices.updateWorkshop(workshop: workshop, completion: {(bool) in
                            print(bool)
                            })
                        print(id)
                        
                    }
                                   
                                  
                    self.workshopServices.getWorkShop { (workshops) in

                    self.mainImageView.isHidden = false
                    self.requestDescription.isHidden = false
                    self.titleRequest.isHidden = false
                    self.cameraButton.isHidden = false
                    self.libraryButton.isHidden = false
                    self.dateBeginEdt.isHidden = false
                    self.houtBeginEdt.isHidden = false
                    self.hourEndEdt.isHidden = false
                    self.categorieEdt.isHidden = false
                    self.maxPeople.isHidden = false
                        
                    self.spener.isHidden = true
                    self.spener.stopAnimating()
                        let workshopController = WorkshopCollectionViewController.newInstance(workshops: workshops)
                        
                        self.navigationController?.pushViewController(workshopController, animated: true)
                        
                        print(resp)
                        
                    }

            }
    }
    func Update(image : UIImage?, workshop: WorkShop){
        print(workshop)
        let parameters = WorkShopFactory.dictionaryFrom(workShop: workshop)
        print("Json param")
        print(parameters)
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
                to: "http://localhost:7000/api/addNewWorkshop", method: .post , headers: headers)
                .response { resp in
                    print("here")
                    print(resp.debugDescription)
                    print(resp.data)
                    
                    self.workshopServices.getWorkShop { (workshops) in

                    self.mainImageView.isHidden = false
                    self.requestDescription.isHidden = false
                    self.titleRequest.isHidden = false
                    self.cameraButton.isHidden = false
                    self.libraryButton.isHidden = false
                    self.dateBeginEdt.isHidden = false
                    self.houtBeginEdt.isHidden = false
                    self.hourEndEdt.isHidden = false
                    self.categorieEdt.isHidden = false
                    self.maxPeople.isHidden = false
                        
                    self.spener.isHidden = true
                    self.spener.stopAnimating()
                        let workshopController = WorkshopCollectionViewController.newInstance(workshops: workshops)
                        
                        self.navigationController?.pushViewController(workshopController, animated: true)
                        
                        print(resp)
                        
                    }

            }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd-MM-yyyy"
         
         dateBeginEdt.text = dateFormatter.string(from: datePicker.date)
         view.endEditing(true)
     }
     
     @objc func hourEndingChanged(datePicker: UIDatePicker) {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "HH:mm"
         
         hourEndEdt.text = dateFormatter.string(from: datePicker.date)
         view.endEditing(true)
     }
     
     @objc func hourBeginChanged(datePicker: UIDatePicker) {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "HH:mm"
         
         houtBeginEdt.text = dateFormatter.string(from: datePicker.date)
         view.endEditing(true)
     }
    
    @objc func categoryBiganChanged(_ textField: UITextField){

        let vc = CategorysViewController.newInstance(vcname: "workshop")
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
     }
    public func  setCategory(value: String) -> Void {
        self.categorieEdt.value(forKey: value)
    }

   
}


