//
//  AppDelegate.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var username: String?
    var coinsInWallet = [CoinInWallet]()
    var allCoins = [Coin]()
    var ownCoins: Int = 0
    var updating: Bool = false
    var updated: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    func queryCoins() {
        updating = true
        let url = URL(string: "http://35.227.185.35:3000/api/com.alchemistmaterial.test.AlchemistCoin")!
        print("Get all coins from server")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else
            {
                print("dataTask error")
                self.updating = false
                return
            }
            do {
                print("dataTask no error")
                var nCoins = 0
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    self.allCoins = [Coin]()
                    for i in self.coinsInWallet {
                        i.num = 0
                    }

                    for i in jsonArray{
                        //print(i)
                        let coin = Coin(json: i)
                        self.allCoins += [coin!]
                        let owner = i["owner"] as! String?
                        if ((owner != nil) && owner!.hasSuffix(self.username!)) {
                            nCoins = nCoins + 1
                            let design = i["coinDesignId"] as! String?
                            
                            for j in self.coinsInWallet {
                                if (design! == j.name) {
                                    j.num += 1
                                    print("design:\(j.name) num:\(j.num)")
                                }
                            }
                        }
                    }
                    if (nCoins > 0 && nCoins != self.ownCoins) {
                        self.ownCoins = nCoins
                    }
                    self.updated = true
                    self.updating = false
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                self.updated = false
                self.updating = false
                print(error)
            }
            
            /*
            DispatchQueue.main.async {
                print("calling reload")
                self.tableview.reloadData()
                //self.setupTableView()
                self.refreshing = false
            }
             */
        }
        print("calling resume1")
        task.resume()
        print("called resume1")
    }
}

