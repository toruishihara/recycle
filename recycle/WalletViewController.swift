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

    //var coinsInWallet = [CoinInWallet]()
    //var coins = [Coin]()
    
    var timer: Timer!
    //var refreshing: Bool = false
    var firstTime: Bool = true
    
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillApear")
        firstTime = true
        if (app?.updating == false) {
            app?.queryCoins()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        self.setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (self.timer != nil) {
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    func refreshTable() {
        DispatchQueue.main.async {
            print("calling reload")
            self.tableview.reloadData()
        }
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
        return app!.coinsInWallet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CoinTableCell
        cell.parent = self
        cell.backgroundColor = UIColor.white
        cell.CoinNo = Int64(indexPath.row + 1)
        if (indexPath.row < app!.coinsInWallet.count) {
            cell.coinImage!.image = app!.coinsInWallet[indexPath.row].photo
            //cell.coinImage.backgroundColor = .lightGray
            print("index:\(indexPath.row) num:\(app!.coinsInWallet[indexPath.row].num)" )
            cell.coinLabel!.text = String(format: "x %d", app!.coinsInWallet[indexPath.row].num)
            if (app!.coinsInWallet[indexPath.row].num > 0) {
                cell.button1!.isHidden = false
                cell.button2!.isHidden = false
            } else {
                cell.button1!.isHidden = false
                cell.button2!.isHidden = true
            }
        } else {
            print("No image, label")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK
    public func SelectUserAndSend(coin: Coin) {
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
                print("dataTalk error")
                msg = error!.localizedDescription
            }
            else {
                print("dataTalk no error")
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Parsed JSON: '\(jsonStr ?? "none")'")
                msg = "Sent to \(coin.owner)"
            }
            self.showAlert(msg: msg)
        }
        print("calling resume")
        dataTask.resume()
        print("called resume")
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
    
    //MARK: Private Methods

    @objc func timerCallback()
    {
        print("timer updating=\(app!.updating) updated=\(app!.updated)")
        if(app!.updating == false) {
            app!.queryCoins()
        }
        if (firstTime || app!.updated) {
            self.refreshTable()
            app!.updated = false
        }
        firstTime = false
    }
    
    private func loadSampleCoins() {
        let photo1 = UIImage(named: "D01")
        let photo2 = UIImage(named: "D02")
        let photo3 = UIImage(named: "D03")
        let photo4 = UIImage(named: "D04")
        let photo5 = UIImage(named: "D05")
        let photo6 = UIImage(named: "D06")
        let photo7 = UIImage(named: "D07")
        let photo8 = UIImage(named: "D08")

        let coin1 = CoinInWallet(name: "D01", photo: photo1, num: 0)
        let coin2 = CoinInWallet(name: "D02", photo: photo2, num: 0)
        let coin3 = CoinInWallet(name: "D03", photo: photo3, num: 0)
        let coin4 = CoinInWallet(name: "D04", photo: photo4, num: 0)
        let coin5 = CoinInWallet(name: "D05", photo: photo5, num: 0)
        let coin6 = CoinInWallet(name: "D06", photo: photo6, num: 0)
        let coin7 = CoinInWallet(name: "D07", photo: photo7, num: 0)
        let coin8 = CoinInWallet(name: "D08", photo: photo8, num: 0)

        app!.coinsInWallet += [coin1!, coin2!, coin3!, coin4!, coin5!, coin6!, coin7!, coin8!]
    }
    

}
