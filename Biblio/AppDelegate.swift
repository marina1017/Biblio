//
//  AppDelegate.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/29.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Firebaseの広告周り
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")

        //ストーリーボードなしで実装
        let first: ViewController = ViewController()
        first.view.backgroundColor = UIColor.white
        let navigationController = UINavigationController(rootViewController: first)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        
        return true
    }

}

