//
//  ProfileViewController.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 16/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit



class ProfileViewController: UIViewController  {
    class func newInstance(user: User) -> ProfileViewController {
        
        let vc = ProfileViewController()
        ProfileViewController.user = user
        return vc
    }
    var height = 0;
    let userServices = UserWebService();
    static var user = User(email: "",password: "")
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 88,
                                width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
        
        view.addSubview(messageButton)
        messageButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                             paddingTop: 64, paddingLeft: 32, width: 32, height: 32)
        
        view.addSubview(followButton)
        followButton.anchor(top: view.topAnchor, right: view.rightAnchor,
                             paddingTop: 64, paddingRight: 32, width: 32, height: 32)
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)

        emailLabel.text = ProfileViewController.user.email
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
        return view
    }()
    lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 0.8)
        view.addSubview(firstnameLabel)
        firstnameLabel.anchor(top: view.topAnchor, left:  view.leftAnchor, bottom:  nil, right: nil, paddingTop:  80 ,
        paddingLeft:  50, paddingBottom:  0, paddingRight: 0, width:  400, height:  70)
        view.addSubview(requestissueLabel)
        view.addSubview(lastnameLabel)
        lastnameLabel.anchor(top: firstnameLabel.topAnchor, left:  view.leftAnchor, bottom:  nil, right: nil, paddingTop:  0 ,
        paddingLeft:  400, paddingBottom:  0, paddingRight: 0, width:  400, height:  70)
        view.addSubview(requestissueLabel)
        requestissueLabel.anchor(top: lastnameLabel.bottomAnchor, left:  view.leftAnchor, bottom:  nil, right: nil, paddingTop:  0,
        paddingLeft:  50, paddingBottom:  0, paddingRight: 0, width:  400, height:  70)
        
        view.addSubview(requestcrtLabel)
        requestcrtLabel.anchor(top: requestissueLabel.topAnchor, left:  view.leftAnchor, bottom:  nil, right: nil, paddingTop:  0,
        paddingLeft:  400, paddingBottom:  0, paddingRight: 0, width:  400, height:  70)
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        var image = UIImage(named: user.photo!)
        if (image != nil) {
            iv.image = image
        } else {
            iv.image = UIImage(named: "pic1")
        }
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_mail_outline_white_2x").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMessageUser), for: .touchUpInside)
        return button
    }()
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_person_add_white_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleFollowUser), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = user.pseudo
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    let firstnameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Nom: \(user.firstname!)"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    let lastnameLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .left
           label.text = "Prenom: \(user.lastname!)"
           label.font = UIFont.boldSystemFont(ofSize: 18)
           label.textColor = .black
           return label
       }()
    let requestcrtLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Nombre de requetes effectuée: \(user.requestFulfilled!)"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    let requestissueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Nombre d'atelier realisé: \(user.requestIssued!) "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = user.email
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        userServices.getconnectedUser { (users) in
            print(users)
            ProfileViewController.self.user = users
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 0.77)
        statusBar.height = navigationController!.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        print("yes here \(height)")
        self.navigationItem.title = "Profil"
        navigationController?.title = "Profil"
        view.addSubview(containerView)
        view.addSubview(bottomContainerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: statusBar.height + 100 ,
        paddingLeft:  0, paddingBottom:  0, paddingRight:  0, width: nil, height: 300)
        
        bottomContainerView.anchor(top: view.topAnchor, left:  view.leftAnchor, bottom:  nil, right: view.rightAnchor, paddingTop:  421 ,
        paddingLeft:  0, paddingBottom:  0, paddingRight: 0, width:  nil, height:  300)
        
    }
    
    
    
    
    // MARK: - Selectors
    
    @objc func handleMessageUser() {
        print("Message user here..")
    }
    
    @objc func handleFollowUser() {
        print("Follow user here..")
    }
}

extension UIColor {
   
    
    static let mainGreen = UIColor(red: 91/255, green: 128/255, blue: 185/255, alpha: 0.7)
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0 ,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

}

struct statusBar {
    static var height: CGFloat = 0;
}
