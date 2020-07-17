//
//  createWorkShopViewController.swift
//  wolcare
//
//  Created by Arnaud Salomon on 12/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class createWorkShopViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    

    @IBOutlet weak var workShopImg: UIImageView!
    @IBOutlet var titleTxt: UILabel!
    @IBOutlet var titleEdt: UITextField!
    @IBOutlet var dateBeginTxt: UILabel!
    @IBOutlet var dateBeginEdt: UITextField!
    @IBOutlet var HourBeginTxt: UILabel!
    @IBOutlet var houtBeginEdt: UITextField!
    @IBOutlet var hourEndTxt: UILabel!
    @IBOutlet var hourEndEdt: UITextField!
    @IBOutlet var descriptionTxt: UILabel!
    @IBOutlet var descriptionEdt: UITextView!
    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var libraryButton: UIButton!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    private var dateBeginPicker: UIDatePicker?
    private var hourBeginPicker: UIDatePicker?
    private var hourEndPicker: UIDatePicker?
    
    
    
    
    var categoryData: [String] = [String]()
    
let workShopService: WorkShopService = WorkShopService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spiner.isHidden = true
        
        categoryData = ["Jardinage", "Bricolage", "Social", "Transport", "Achats", "Autre"]
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        let image: UIImage = UIImage(named: "workshop")!
        
        
        workShopImg = UIImageView(image: image)
 
       // self.view.addSubview(workShopImg!)
        
        self.workShopImg.image = image
        self.workShopImg.setNeedsDisplay()
        self.workShopImg.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.title = "Nouvel Atelier"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWorkShop))
        
        dateBeginPicker = UIDatePicker()
        dateBeginPicker?.datePickerMode = .date
        
        hourBeginPicker = UIDatePicker()
        hourBeginPicker?.datePickerMode = .time
        
        hourEndPicker = UIDatePicker()
        hourEndPicker?.datePickerMode = .time
        
        dateBeginPicker?.addTarget(self, action:
            #selector(createWorkShopViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        hourBeginPicker?.addTarget(self, action:
        #selector(createWorkShopViewController.hourBeginChanged(datePicker:)), for: .valueChanged)
        
        hourEndPicker?.addTarget(self, action:
        #selector(createWorkShopViewController.hourEndingChanged(datePicker:)), for: .valueChanged)
        
        dateBeginEdt.inputView = dateBeginPicker
        hourEndEdt.inputView = hourEndPicker
        houtBeginEdt.inputView = hourBeginPicker
        
        navigationItem.title = "Nouvel Atelier"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(createWorkShopViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
    }
    @IBAction func camera(sender: Any?) {
          presentUIImagePicker(sourceType: .camera)
      }
      
      @IBAction func library(sender: Any?) {
          presentUIImagePicker(sourceType: .photoLibrary)
      }
    private func presentUIImagePicker(sourceType: UIImagePickerController.SourceType) {
           let picker = UIImagePickerController()
           picker.delegate = self
           picker.sourceType = sourceType
           present(picker, animated: true, completion: nil)
       }
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
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
    
    
    @objc func addWorkShop() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateBegin = "\(dateBeginEdt.text!) \(houtBeginEdt.text!)"
        let datEnding =  "\(dateBeginEdt.text!) \(hourEndEdt.text!)"
        
        let begin = dateFormatter.date(from: dateBegin)!
        let end = dateFormatter.date(from: datEnding)!

        
        guard let idCreator = self.titleTxt.text,
            let title = self.titleEdt.text,
              let beginAt: Date? = begin,
              let datEnd: Date? = end,
              let status: Int? = 0,
            let detail: String = self.descriptionEdt.text ?? "bug?",
              let category = self.titleEdt.text // a replacer par la roulette -> faire comme pour le selecteur de date ?
        
  // Probleme avec la date et API, API = date debut + fin ( heure incluse) et non date debut , heure fin , heure debut
              else {
                return
        }

        let workShop = WorkShop(id: nil, idCategory: nil, idCreator: nil, idIntervenant: nil, title: title, maxPeoplesAllowed: 4, status: 0, dateAvailable: begin.debugDescription, createAt: nil, datEnd: end.debugDescription, photoPath: "photoPath", WorkshopDescription: "test des")
            

        self.workShopService.neWorkShop(workShop: workShop) { (success) in
            print("\(success)")
        }

            self.navigationController?.pushViewController(HomeViewController(), animated: true)
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryData[row]
    }
    
    

}
extension createWorkShopViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
            dismiss(animated: true, completion: nil)
            
            return
        }
        DispatchQueue.main.async {
            self.workShopImg.image = chosenImage
            self.workShopImg.setNeedsDisplay()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
   
}

