//
//  AppDelegate.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/29.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import Firebase
import DrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //起動時に実行される関数
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Firebaseの広告周り
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")

        let bookListViewController = BookListViewController()
        bookListViewController.view.backgroundColor = UIColor.white
        let leftViewController = LeftViewController()
        let drawerController = DrawerController(
            centerViewController: UINavigationController(rootViewController: bookListViewController),
            leftDrawerViewController: UINavigationController(rootViewController: leftViewController))
        drawerController.shouldStretchDrawer = false
        drawerController.maximumLeftDrawerWidth = 250.0
        drawerController.closeDrawerGestureModeMask = .all
        drawerController.openDrawerGestureModeMask = .all
        drawerController.animationVelocity = 500
        drawerController.drawerVisualStateBlock = { (drawerController, drawerSide, percentVisible) in
            //この関数がないとAutoLayoutがなんか変
            DrawerVisualState.parallaxVisualStateBlock(parallaxFactor: 4.0)(drawerController, drawerSide, percentVisible)
        }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = drawerController
        self.window?.makeKeyAndVisible()
        return true
    }

}

