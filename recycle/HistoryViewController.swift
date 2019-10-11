//
//  HistoryViewController.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = self.view.frame.width
        let h = self.view.frame.height

        let topColor = UIColor(red:128/255, green:128/255, blue:128/255, alpha:1)
        let bottomColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = CGRect(x:0, y:0, width:w, height:h)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        let gv = GraphView(frame: CGRect(x: 50, y: 50, width: w-100, height: w-100))
        view.addSubview(gv)

        let label0 = UILabel(frame: CGRect(x: 30, y: 0, width: w - 60, height: 30))
        label0.center = CGPoint(x: w/2 , y: w + 10)
        label0.textAlignment = .center
        label0.textColor = UIColor.black
        label0.font = UIFont.boldSystemFont(ofSize: 20.0)
        label0.text = "Available Coin:             12 Coins"
        
        let gradientColors2: [CGColor] = [bottomColor.cgColor, topColor.cgColor]
        let gradientLayer2: CAGradientLayer = CAGradientLayer()
        gradientLayer2.colors = gradientColors2
        gradientLayer2.frame = label0.frame
        self.view.layer.insertSublayer(gradientLayer2, at:1)
        self.view.addSubview(label0)
        
        /*
        let w = self.view.frame.width
        let h = self.view.frame.height

        let base_y = 0.6*h
        let base_x = 0.1*w
        let graph_w = 0.8*w
        let graph_h = 0.8*w
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: base_x, y: base_y - graph_h))
        path1.addLine(to: CGPoint(x: base_x, y: base_y))
        path1.addLine(to: CGPoint(x: base_x + graph_w , y: base_y))
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.strokeColor = UIColor.blue.cgColor
        shapeLayer1.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer1)
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: base_x, y: base_y))
        path2.addLine(to: CGPoint(x: base_x + 80, y: base_y - 40))
        path2.addLine(to: CGPoint(x: base_x + 160 , y: base_y - 90))
        path2.addLine(to: CGPoint(x: base_x + 240 , y: base_y - 190))
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.strokeColor = UIColor.green.cgColor
        shapeLayer2.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer2)
        
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: base_x, y: base_y))
        path3.addLine(to: CGPoint(x: base_x + 80, y: base_y - 20))
        path3.addLine(to: CGPoint(x: base_x + 160 , y: base_y - 60))
        path3.addLine(to: CGPoint(x: base_x + 240 , y: base_y - 120))
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = path3.cgPath
        shapeLayer3.fillColor = UIColor.clear.cgColor
        shapeLayer3.strokeColor = UIColor.orange.cgColor
        shapeLayer3.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer3)
        
        let label0 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 16))
        label0.center = CGPoint(x: base_x + 240 , y: base_y - 190 - 10)
        label0.textAlignment = .center
        label0.textColor = UIColor.black
        label0.font = UIFont.boldSystemFont(ofSize: 15.0)
        label0.text = "23,001,325"
        self.view.addSubview(label0)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 16))
        label1.center = CGPoint(x: base_x + 240 , y: base_y - 120 - 10)
        label1.textAlignment = .center
        label1.textColor = UIColor.black
        label1.font = UIFont.boldSystemFont(ofSize: 15.0)
        label1.text = "14,573,124"
        self.view.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 10, y: base_y + 20, width: w - 10, height: 16*8))
        label2.textAlignment = .left
        label2.textColor = UIColor.black
        label2.font = UIFont.boldSystemFont(ofSize: 15.0)
        label2.numberOfLines = 0
        label2.lineBreakMode = .byTruncatingTail
        label2.text = "You are,\n\nIn your neighbor 27/89\nIn your city 1,733/3,211\nIn your country 391,182/730,199\nIn the world 14,573,124/23,001,325"
        self.view.addSubview(label2)
 */


    }
}
