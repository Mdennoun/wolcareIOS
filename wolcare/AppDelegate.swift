//
//  AppDelegate.swift
//  wolcare
//
//  Created by Mohamed dennoun on 07/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let w = UIWindow(frame: UIScreen.main.bounds)
        w.rootViewController =  UINavigationController(rootViewController: LoginViewController())
        w.makeKeyAndVisible()
        self.window = w

        return true
        
    }



}

