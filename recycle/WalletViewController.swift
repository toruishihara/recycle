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
    var app: AppDelegate?

    var coinsInWallet = [CoinInWallet]()
    var coins = [Coin]()
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.separatorColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        app = (UIApplication.shared.delegate as! AppDelegate)
        print("WalletViewController viewDidLoad")

        loadSampleCoins()
        //refreshTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillApear")
        refreshTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        self.setupTableView()
    }
    
    func refreshTable() {
        coins = [Coin]()
        for i in coinsInWallet {
            i.num = 0
        }
        let url = URL(string: "http://35.227.185.35:3000/api/com.alchemistmaterial.test.AlchemistCoin")!
        print("Get all coins from server")
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    for i in jsonArray{
                        //print(i)
                        let coin = Coin(json: i)
                        self.coins += [coin!]
                        let owner = i["owner"] as! String?
                        if ((owner != nil) && owner!.hasSuffix(self.app!.username!)) {
                            let design = i["coinDesignId"] as! String?
                            
                            for j in self.coinsInWallet {
                                if (design! == j.name) {
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
                print("calling reload")
                self.tableview.reloadData()
                //self.setupTableView()
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
        return coinsInWallet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CoinTableCell
        cell.backgroundColor = UIColor.white
        print("index=\(indexPath.row)")
        if (indexPath.row < coinsInWallet.count) {
            cell.coinImage.image = coinsInWallet[indexPath.row].photo
            //cell.coinImage.backgroundColor = .lightGray
            cell.coinLabel.text = String(format: "x %d", coinsInWallet[indexPath.row].num)
            if (coinsInWallet[indexPath.row].num > 0) {
                cell.coinLabel2.text = "Send"
                cell.coinLabel2.backgroundColor = .lightGray
            } else {
                cell.coinLabel2.text = ""
                cell.coinLabel2.backgroundColor = .white
            }
        } else {
            print("No image, label")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func httpPut(coin:Coin) {
        print("httpPut")
        let url = NSURL(string: "http://35.227.185.35:3000/api/com.alchemistmaterial.test.AlchemistCoin/" + coin.coinId) //Remember to put ATS exception if the URL is not https
        let request = NSMutableURLRequest(url: url! as URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Optional
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = coin.GetJson().data(using: .utf8)

        request.httpMethod = "PUT"
        let session = URLSession(configuration:URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)

        var msg:String = ""
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if error != nil {
                msg = error!.localizedDescription
            }
            else {
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Parsed JSON: '\(jsonStr ?? "none")'")
                msg = "Sent to \(coin.owner)"
            }
            self.showAlert(msg: msg)
        }
        dataTask.resume()
    }

    func showAlert(msg:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("reloadData")
                    self.refreshTable()

                case .cancel:
                    print("cancel")

                case .destructive:
                    print("destructive")

                default:
                    print("alert default")

                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        //print("row: \(indexPath.row)")
        //let nextVC = ShopViewController()
        //self.present(nextVC, animated: true, completion: nil)
        var coin:Coin?
        let designId:String = String(format: "D%02d", indexPath.row+1)
        
        for i in coins {
            if (i.owner == app!.username && i.coinDesignId == designId) {
                coin = i
                break
            }
        }
        if (coin == nil) {
            print("No Coin Found")
            return
        }
        selectUserAndSend(coin:coin!)
        //httpPut(coin:coin!)
        return
    }
    //MARK: Private Methods

    private func loadSampleCoins() {
        let photo1 = UIImage(named: "D01")
        let photo2 = UIImage(named: "D02")
        let photo3 = UIImage(named: "D03")
        let photo4 = UIImage(named: "D04")
        let photo5 = UIImage(named: "D05")
        let photo6 = UIImage(named: "D06")
        let photo7 = UIImage(named: "D07")

        let coin1 = CoinInWallet(name: "D01", photo: photo1, num: 0)
        let coin2 = CoinInWallet(name: "D02", photo: photo2, num: 0)
        let coin3 = CoinInWallet(name: "D03", photo: photo3, num: 0)
        let coin4 = CoinInWallet(name: "D04", photo: photo4, num: 0)
        let coin5 = CoinInWallet(name: "D05", photo: photo5, num: 0)
        let coin6 = CoinInWallet(name: "D06", photo: photo6, num: 0)
        let coin7 = CoinInWallet(name: "D07", photo: photo7, num: 0)

        coinsInWallet += [coin1!, coin2!, coin3!, coin4!, coin5!, coin6!, coin7!]
    }
    
    func selectUserAndSend(coin: Coin) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Send to", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "USER01", style: .default, handler: { (_) in
                coin.owner = "USER01"
                self.httpPut(coin:coin)
            }))

            alert.addAction(UIAlertAction(title: "USER02", style: .default, handler: { (_) in
                print("USER02")
                coin.owner = "USER02"
                self.httpPut(coin:coin)
            }))

            alert.addAction(UIAlertAction(title: "USER03", style: .default, handler: { (_) in
                coin.owner = "USER03"
                self.httpPut(coin:coin)
            }))
        
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }

    }

}
