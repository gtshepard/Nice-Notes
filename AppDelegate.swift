//
//  AppDelegate.swift
//  Nice Notes
//
//  Created by Garrison Shepard on 9/11/18.
//  Copyright © 2018 Garrison. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let dataController = DataController(modelName: "Nice_Notes")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        //to load persistent data as soon app starts
        //note load has option for completion handler.
        dataController.load()
        
        
        // inject a controller dependency to set data controler for main view controller
        //this way data is always laoded upon satrt i
        let navigationController = window?.rootViewController as! UINavigationController
        let noteListViewController = navigationController.topViewController as! ViewController
        noteListViewController.dataController = dataController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
}

