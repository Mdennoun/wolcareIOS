//
//  CategorysViewController.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 15/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

//
//  CategorysViewController.swift
//  wolcare
//
//  Created by DENNOUN Mohamed on 15/07/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import Foundation

class CategorysViewController: UIViewController {

    class func newInstance(vcname: String) -> CategorysViewController {
        
        let vc = CategorysViewController()
        vc.vcname = vcname
        categorie.vc = vcname
        return vc
    }
    
lazy var backdropView: UIView = {
    let bdView = UIView(frame: self.view.bounds)
    bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return bdView
}()
    
var vcname = ""
var menuView : TopView?
let menuHeight = UIScreen.main.bounds.height / 2
var isPresenting = false

init() {
    super.init(nibName: nil, bundle: nil)
    
    modalPresentationStyle = .custom
    transitioningDelegate = self
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    let categoryServices: CategoryService = CategoryService()
    public var categorys = [CategoryModel]()
    
    func CategoryInCollection() {
              self.categoryServices.getCategorys { (categorys) in
                self.menuView = TopView.newInstance(categorys: categorys)
                print(categorys)

                self.view.addSubview(self.menuView!)
                

                self.menuView!.backgroundColor = .red
                self.menuView!.translatesAutoresizingMaskIntoConstraints = false
                self.menuView!.heightAnchor.constraint(equalToConstant: self.menuHeight).isActive = true
                self.menuView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                self.menuView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                self.menuView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                  
              }
          }

override func viewDidLoad() {
    super.viewDidLoad()

    
    view.backgroundColor = .clear
    view.addSubview(backdropView)
    
    CategoryInCollection()

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CategorysViewController.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
    Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.updateVar), userInfo: nil,  repeats: true) }

    @objc func updateVar() {
        if(categorie.isHidden) {
             dismiss(animated: true, completion: nil)
            
            
        }
    }

@objc func handleTap(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
}
}

extension CategorysViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
}

func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
}

func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1
}

func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    guard let toVC = toViewController else { return }
    isPresenting = !isPresenting
    categorie.isHidden = !isPresenting
    self.categoryServices.getCategorys { (categorys) in
        self.menuView = TopView.newInstance(categorys: categorys)
        if self.isPresenting == true {
                  
                   
                   containerView.addSubview(toVC.view)

                   self.menuView!.frame.origin.y += self.menuHeight
                   self.backdropView.alpha = 0

                   UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                       self.menuView!.frame.origin.y -= self.menuHeight
                       self.backdropView.alpha = 1
                   }, completion: { (finished) in
                       transitionContext.completeTransition(true)
                   })
               } else {
                   UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                       self.menuView!.frame.origin.y += self.menuHeight
                       self.backdropView.alpha = 0
                   }, completion: { (finished) in
                       transitionContext.completeTransition(true)
                   })
               }
           }

}
}




 
