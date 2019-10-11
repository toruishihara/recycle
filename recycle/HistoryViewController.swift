//
//  HistoryViewController.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    let topColor = UIColor(red:128/255, green:128/255, blue:128/255, alpha:1)
    let bottomColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha:1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = self.view.frame.width
        let h = self.view.frame.height

        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = CGRect(x:0, y:0, width:w, height:h)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        let gv = GraphView(frame: CGRect(x: 50, y: 20, width: w-100, height: w-100))
        view.addSubview(gv)

        var y2 = w - 70
        let label0 = UILabel(frame: CGRect(x: 30, y: y2, width: w - 60, height: 30))
        y2 = y2 + 40
        setLabel(label: label0, text: "Available Coin:               12 Coins")
        //setHtmlLabel(label: label0, text: "<font face=\"Arial\"><h2>Available Coin:               12 Coins</h2></font>")
        self.view.addSubview(label0)

        let label1 = UILabel(frame: CGRect(x: 30, y: y2, width: w - 60, height: 60))
        y2 = y2 + 70
        setLabel(label: label1, text: "Lifetime Earned Coin: 121 Coins\nRanking:    1,008th out of 219,872")

        //setHtmlLabel(label: label1, text: "<font face=\"Arial\"><h2>Lifetime Earned Coin: 121 Coins</h2><h2>Ranking:    1,008th</h2><h4>out of</h4><h2>219,872</h2></font>")
        self.view.addSubview(label1)

        let label2 = UILabel(frame: CGRect(x: 30, y: y2, width: w - 60, height: 60))
        y2 = y2 + 70
        setLabel(label: label2, text: "Earned Coin (MTD):       194 Coins\nRanking:       24th out of 19,125")
        self.view.addSubview(label2)

        let label3 = UILabel(frame: CGRect(x: 30, y: y2, width: w - 60, height: 160))
        setLabel(label: label3, text:  "Transaction\nDate    Earned/Redeemed      Coin\n09/24/2019  Earned  4\n09/21/2019  Redeemed  4\n09/04/2019  Earned  4\n08/24/2019  Earned  4")
        self.view.addSubview(label3)
    }
    
    func setLabel(label:UILabel, text:String) {
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.text = text
        
        let gradientColors: [CGColor] = [bottomColor.cgColor, topColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = label.frame
        self.view.layer.insertSublayer(gradientLayer, at:1)
    }
    
    func setHtmlLabel(label:UILabel, text:String) {
        //label.textAlignment = .left
        //label.textColor = UIColor.black
        //label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let data = text.data(using: String.Encoding.unicode)! // mind "!"
        let attrStr = try? NSMutableAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        label.attributedText = attrStr

        let gradientColors: [CGColor] = [bottomColor.cgColor, topColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = label.frame
        self.view.layer.insertSublayer(gradientLayer, at:1)
    }

}
