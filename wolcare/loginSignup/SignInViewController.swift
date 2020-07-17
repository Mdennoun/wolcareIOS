//
//  SignInViewController.swift
//  wolcare
//
//  Created by Arnaud Salomon on 09/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
//, UIPickerViewDelegate, UIPickerViewDataSource
class SignInViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
     /* func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }*/
    
 
    @IBOutlet var avatarTxt: UILabel!
    
    @IBOutlet var pseudoEdt: UITextField!
    @IBOutlet var passwordEdt: UITextField!
    @IBOutlet var firstnameEdt: UITextField!
    @IBOutlet var nameEdt: UITextField!
    @IBOutlet var emailEdt: UITextField!
    @IBOutlet var birthdateEdt: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var genderSwitch: UISegmentedControl!
    
    
    private var datePicker: UIDatePicker?
    private var photos = [UIImage(named: "pic1"), UIImage(named: "pic2"), UIImage(named: "pic3"), UIImage(named: "pic4"), UIImage(named: "pic5"), UIImage(named: "pic6"), UIImage(named: "pic7"), UIImage(named: "pic8"), UIImage(named: "pic9")]
  
    let userWebService: UserWebService = UserWebService()
    
  
    
   // var genderData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(confirm))
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action:
            #selector(WorkshopCreateViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        birthdateEdt.inputView = datePicker
        
        navigationItem.title = "Inscription"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        //self.genderPicker.delegate = self
        //self.genderPicker.dataSource = self
        //genderData = ["un Homme", "une Femme"]
        collectionView.delegate = self
        collectionView.dataSource = self
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AvatarCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_AVATAR_CELL_IDENTIFER")
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        self.collectionView.addGestureRecognizer(tap)

        self.collectionView.isUserInteractionEnabled = true
    
    }
        
        
  
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
       if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
        //Do your stuff here
        print("test")
        print(indexPath.row)
        choosen.index = indexPath.row
        collectionView.reloadData()
        }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        birthdateEdt.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return photos.count
       }
       
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_AVATAR_CELL_IDENTIFER", for: indexPath) as! AvatarCollectionViewCell
        if(choosen.index != 99) {
            if(indexPath.row == choosen.index) {
                cell.choose.isHidden = false
                choosen.path = "pic" + indexPath.row.description
            } else {
                cell.choose.isHidden = true
                
            }
        }
        cell.picture?.image = photos[indexPath.row]
        //set swipe for gesture recongnizer
        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(reset) )
        //set direction
        UpSwipe.direction = UISwipeGestureRecognizer.Direction.up
        //set geture for cell
        cell.addGestureRecognizer(UpSwipe)
     
        return cell
    }
    @objc func reset(sender: UISwipeGestureRecognizer) {
          
          let cell = sender.view as! UICollectionViewCell
              print("tapped rest")
        
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("why")
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_AVATAR_CELL_IDENTIFER", for: indexPath) as! AvatarCollectionViewCell
        cell.choose.isHidden = false
         
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
           {
            let width  = (self.view.frame.width-20)/3
            print(width.description)
                 return CGSize(width: width, height: width)
           }
    
    @objc func confirm() {
        let date = Date().debugDescription
        print(date)
        
        guard let email = self.emailEdt.text,
              let password = self.passwordEdt.text,
              let pseudo = self.pseudoEdt.text,
              let firstname = self.firstnameEdt.text,
              let lastname = self.nameEdt.text,
              let birthdate = self.birthdateEdt.text,
              let photo = Optional(choosen.path)
              //let sex = true,
              else {
                return
        }
        
        let user = User(_id: nil,email: email, password: password, type: "IOS", pseudo: pseudo, firstname: firstname, lastname: lastname,
                        birthdate: birthdate, sex: true, photo: photo, requestIssued: 0, requestFulfilled: 0)
        
        self.userWebService.newUser(user: user) { (success) in
            print("\(success)")
        }
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }



}
struct choosen {
    static var index = 99;
    static var path = ""
}
