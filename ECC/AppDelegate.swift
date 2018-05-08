//
//  AppDelegate.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        //Check if a school was selected for themeing
        if(UserDefaults.standard.string(forKey: "kSchoolSelection") != nil)
        {
            let school = UserDefaults.standard.string(forKey: "kSchoolSelection")
            
            if(school == "LakeView")
            {
                let lake_view = UIColor.init(named: "Lake_View") ?? UIColor.red

                UINavigationBar.appearance().barTintColor = lake_view
                UITabBar.appearance().tintColor = lake_view
            }
            else
            {
                let michele_clark = UIColor.init(named: "Michele_Clark") ?? UIColor.yellow

                UINavigationBar.appearance().barTintColor = michele_clark
                UITabBar.appearance().tintColor = michele_clark
            }
            
            //Common
            UINavigationBar.appearance().barStyle = .black
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        else
        {
            let dark_grey = UIColor.init(named: "Dark_Grey") ?? UIColor.darkGray
                
            UITabBar.appearance().tintColor = dark_grey
            UINavigationBar.appearance().tintColor = dark_grey
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: dark_grey]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: dark_grey]
        }

        return true
    }

    
    
    
    //Lifecyle
    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

