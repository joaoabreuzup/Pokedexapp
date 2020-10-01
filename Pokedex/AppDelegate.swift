//
//  AppDelegate.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 29/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeScreenViewController(viewModel: HomeScreenViewModel())
        window?.makeKeyAndVisible()
        return true
        
    }

}

