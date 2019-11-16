//
//  WalletTableViewCell.swift
//  recycle
//
//  Created by TORU ISHIHARA on 10/9/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class CoinTableCell: UITableViewCell {
    var CoinNo:Int64 = 0
    var app:AppDelegate?
    var parent:WalletViewController?
    var cellView:UIView?
    var coinImage: UIImageView?
    var coinLabel: UILabel?
    var button1:UIButton?
    var button2:UIButton?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        app = (UIApplication.shared.delegate as! AppDelegate)

        setupView()
    }
    func setupView() {
        cellView = UIView()
        cellView!.backgroundColor = UIColor.white
        cellView!.layer.cornerRadius = 10
        cellView!.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cellView!)
        coinImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        cellView!.addSubview(coinImage!)
        
        coinLabel = UILabel(frame: CGRect(x: 100, y: 20, width: 60, height: 50))
        coinLabel!.textColor = UIColor.black
        coinLabel!.font = UIFont.boldSystemFont(ofSize: 32)
        cellView!.addSubview(coinLabel!)
        
        button1 = UIButton(frame: CGRect(x: 170, y: 20, width: 80, height: 50))
        button1!.backgroundColor = .black
        button1!.setTitle("Link", for: .normal)
        button1!.addTarget(self, action:#selector(self.button1Clicked), for: .touchUpInside)

        button2 = UIButton(frame: CGRect(x: 260, y: 20, width: 80, height: 50))
        button2!.backgroundColor = .black
        button2!.setTitle("Send", for: .normal)
        button2!.addTarget(self, action:#selector(self.button2Clicked), for: .touchUpInside)

        cellView!.addSubview(button1!)
        cellView!.addSubview(button2!)

        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView!.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView!.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func button1Clicked() {
        var url = URL(string: "https://www.coke.com")
        print("Button1 Clicked")
        if (self.CoinNo == 2) {
             url = URL(string: "https://www.alchemist-material.com")
        } else if (self.CoinNo == 3) {
             url = URL(string:"https://www.amazon.com/Love-Live-Sunshine-Seasons-Blu-ray/dp/B07T3NQ9S2/ref=sr_1_6?keywords=love+live&qid=1573942961&sr=8-6")
        } else if (self.CoinNo == 4) {
             url = URL(string: "https://www.starbucks.com")
        } else if (self.CoinNo == 5) {  // AKB
             url = URL(string: "https://www.youtube.com/watch?v=0pKfxbCHLoU")
        } else if (self.CoinNo == 6) {
            url = URL(string: "https://www.youtube.com/channel/UC6IMGCz0Pjwt2icerqPIuZg") // Oretachi channel
        } else if (self.CoinNo == 7) {
             url = URL(string: "https://www.youtube.com/watch?v=GM3SIBr7NvI&t=34s") // hikakin
        } else if (self.CoinNo == 8) {
             url = URL(string: "https://www.kirin.co.jp/entertainment/cm/player.html?v=hkaG3zljDeY&list=PLA61bUUkTUteeJdBiOT1cWioUEi80T5MX")
        }

        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }

    @objc func button2Clicked() {
        print("Button2 Clicked")
        // Do what you want
        var coin:Coin?
        let designId:String = String(format: "D%02d", self.CoinNo)
        
        for i in app!.allCoins {
            if (i.owner == app!.username && i.coinDesignId == designId) {
                coin = i
                print(coin!)
                break
            }
        }
        if (coin == nil) {
            print("No Coin Found")
            return
        }
        parent!.SelectUserAndSend(coin:coin!)
    }
}
