//
//  MessageViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 27/06/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    private var messages = [String]()
    @IBOutlet var message: UITextView!
    var keyboardVisible = false
    @IBOutlet var collectionView: UICollectionView!
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        message.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.message.delegate = self
        self.navigationItem.title = "Messages"
        collectionView.delegate = self
        collectionView.dataSource = self
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MessageCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "MESSAGE_CELL_IDENTIFER")
        navigationController?.title = "Messages"
        
        
        collectionView.reloadData()
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count \(messages.count)")
        collectionView.reloadData()
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MESSAGE_CELL_IDENTIFER", for: indexPath) as! MessageCollectionViewCell
               
        
        cell.text!.text = message.text
        cell.text.layer.borderColor  = UIColor.blue.cgColor
        cell.text.layer.cornerRadius = 10
        cell.text.layer.masksToBounds = true
        cell.text.layer.borderWidth = 3
        cell.text.textAlignment = .center
        cell.text.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(14))
        cell.text.layer.borderColor  = UIColor.red.cgColor
        
        
        cell.picture?.isHidden = true
        //cell.pictureL?.image
        
        return cell
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        moveTextView(textView, moveDistance: -270, up: true)
    }

    // Finish Editing The Text Field
    func textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(textView, moveDistance: -270, up: false)
        
    }

    // Hide the keyboard when the return key pressed
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    

    // Move the text field in a pretty animation!
    func moveTextView(_ textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)

        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: moveDuration) {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
            
        }
      
    }
  
   
    

    @IBAction func audioBTN(_ sender: Any) {
    }
    @IBAction func emojiBTN(_ sender: Any) {
    }
    @IBAction func sendMSG(_ sender: Any) {
        messages.append(message.text)
        print(messages.count)
        collectionView.reloadData()
        message.endEditing(true)
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

