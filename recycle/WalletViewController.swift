//
//  WalletViewController.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    //MARK: Properties
    
    var coinsInWallet = [CoinInWallet]()
    var coins = [Coin]()
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("WalletViewController viewDidLoad")

        loadSampleCoins()

//        var str:String? ="[{\"$class\":\"com.alchemistmaterial.test.AlchemistCoin\",\"coinId\":\"Coin11\",\"owner\":\"resource:com.alchemistmaterial.test.ProgramParticipant#USER01\",\"coinType\":\"COMMON\",\"value\":\"1\",\"coinState\":\"OUTSTANDING\",\"coinSponsorId\":\"Cold-Cola\",\"coinDesignId\":\"D01\"},{\"$class\":\"com.alchemistmaterial.test.AlchemistCoin\",\"coinId\":\"Coin12\",\"owner\":\"resource:com.alchemistmaterial.test.ProgramParticipant#USER03\",\"coinType\":\"SPECIAL\",\"value\":\"1\",\"coinState\":\"OUTSTANDING\",\"coinSponsorId\":\"Kanagawa Stadium\",\"coinDesignId\":\"D02\"}]"

        let url = URL(string: "http://35.227.185.35:3000/api/com.alchemistmaterial.test.AlchemistCoin")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    //print(jsonArray) // use the json here
                    for i in jsonArray{
                        let coin = Coin(json: i)
                        self.coins += [coin!]
                        let owner = i["owner"] as! String?
                        if (owner!.hasSuffix("USER01")) {
                            let design = i["coinDesignId"] as! String?
                            //print(i)
                            for j in self.coinsInWallet {
                                print(j.name)
                                print(design!)
                                if (design!.compare(j.name) == .orderedSame) {
                                    j.num += 1
                                }
                            }
                        }
                    }
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.setupTableView()
            }
        }
        task.resume()

    }
    
    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self

        tableview.register(CoinTableCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        //print("numberOfRowsInSection")
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CoinTableCell
        cell.backgroundColor = UIColor.white
        cell.coinImage.image = coinsInWallet[indexPath.row].photo
        cell.coinLabel.text = String(format: "x %d", coinsInWallet[indexPath.row].num)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        //print("row: \(indexPath.row)")
        //let nextVC = ShopViewController()
        //self.present(nextVC, animated: true, completion: nil)
        var coin:Coin?
        
        for i in coins {
            if (i.owner == "USER01") {
                coin = i
                break
            }
        }
        if (coin == nil) {
            return
        }
        
        let url = NSURL(string: "http://35.227.185.35:3000/api/com.alchemistmaterial.test.AlchemistCoin/" + coin!.coinId)

        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = coin!.GetJson().data(using: .utf8)
        
        //create the session object
        let session = URLSession.shared

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    //MARK: Private Methods

    private func loadSampleCoins() {
        let photo1 = UIImage(named: "D01")
        let photo2 = UIImage(named: "D02")
        let photo3 = UIImage(named: "D03")
        let photo4 = UIImage(named: "D04")

        let coin1 = CoinInWallet(name: "D01", photo: photo1, num: 0)
        let coin2 = CoinInWallet(name: "D02", photo: photo2, num: 0)
        let coin3 = CoinInWallet(name: "D03", photo: photo3, num: 0)
        let coin4 = CoinInWallet(name: "D04", photo: photo4, num: 0)

        coinsInWallet += [coin1!, coin2!, coin3!, coin4!]
    }
}

/*
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
 */
