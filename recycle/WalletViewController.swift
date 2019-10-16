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

        setupTableView()
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
        cell.coinImage.image = coins[indexPath.row].photo
        cell.coinLabel.text = String(format: "x %d [SHOP]", coins[indexPath.row].num)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        //print("row: \(indexPath.row)")
        let nextVC = FirstViewController()
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: Private Methods

    private func loadSampleCoins() {
        
        let photo1 = UIImage(named: "coin1")
        let photo2 = UIImage(named: "coin2")
        let photo3 = UIImage(named: "coin3")
        let photo4 = UIImage(named: "coin4")

        guard let coin1 = Coin(name: "CokaCola", photo: photo1, num: 4) else {
            fatalError("Unable to instantiate coin1")
        }

        guard let coin2 = Coin(name: "Starbucks", photo: photo2, num: 5) else {
            fatalError("Unable to instantiate coin2")
        }

        guard let coin3 = Coin(name: "Any", photo: photo3, num: 3) else {
            fatalError("Unable to instantiate coin3")
        }

        guard let coin4 = Coin(name: "Any2", photo: photo4, num: 3) else {
            fatalError("Unable to instantiate coin3")
        }

        coins += [coin1, coin2, coin3, coin4]
    }

}

