//
//  AppDelegate.swift
//  HouseHold
//
//  Created by 吴述军 on 20/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import UIKit
import AVOSCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        TopicModel.registerSubclass()
        StrategyModel.registerSubclass()
        AVOSCloud.setApplicationId("SPM9bUpyxtGUdbrLMbl9IMMM-gzGzoHsz", clientKey: "HMK6nVDGaKU2m7sJAgHq65hN")
        
        
        let tabController = HHTabBarViewController()
        // FF4258
        tabController.tabBar.tintColor = UIColor.init(red: 0xff/255.0, green: 0x42/255.0, blue: 0x58/255.0, alpha: 1)
        tabController.tabBar.shadowImage = UIImage.image(color: UIColor.init(red: 0xf0/255.0, green: 0xe6/255.0, blue: 0xe6/255.0, alpha: 1), height: 0.5)
        
        let home = HomeViewController()
        let navHome = UINavigationController.init(rootViewController: home)
        let homeItem = UITabBarItem()
        homeItem.title = "Home"
        homeItem.image = UIImage.init(named: "tabbar_home")
        homeItem.selectedImage = UIImage.init(named: "tabbar_home_s")
        navHome.tabBarItem = homeItem
        
        let my = MyViewController()
        let navMy = UINavigationController.init(rootViewController: my)
        let myItem = UITabBarItem()
        myItem.title = "Mine"
        myItem.image = UIImage.init(named: "tabbar_my")
        myItem.selectedImage = UIImage.init(named: "tabbar_my_s")
        navMy.tabBarItem = myItem
        
        tabController.viewControllers = [navHome, navMy]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

