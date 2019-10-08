//
//  ProfileViewController.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "profile")!)
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        let topColor = UIColor(red:0.54, green:0.90, blue:0.74, alpha:1)
        let bottomColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = CGRect(x:0, y:0, width:w, height:0.7*h)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        var imageView : UIImageView
        imageView  = UIImageView()
        imageView.image = UIImage(named:"face")
        imageView.frame = CGRect(x: (w-200)/2, y: 100, width: 200, height: 200)
        self.view.addSubview(imageView)
        
        let label0 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 30))
        label0.center = CGPoint(x: w/2, y: 330)
        label0.textAlignment = .center
        label0.textColor = UIColor.white
        label0.font = UIFont.boldSystemFont(ofSize: 30.0)
        label0.text = "John Void"
        self.view.addSubview(label0)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label1.center = CGPoint(x: w/2, y: 380)
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        label1.text = "Total number of bottles recycled : 100"
        self.view.addSubview(label1)

        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label2.center = CGPoint(x: w/2, y: 400)
        label2.textAlignment = .center
        label2.textColor = UIColor.white
        label2.text = "Total amount of AMT earned in life : 100"
        self.view.addSubview(label2)

        let h2 = 0.6*h
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: h))
        path1.addLine(to: CGPoint(x: 0, y: h2))
        path1.addArc(withCenter: CGPoint(x: 50, y: h2), radius: 50, startAngle: .pi, endAngle: .pi*1.5, clockwise: true)
        path1.addLine(to: CGPoint(x: w-50, y: h2-50))
        path1.addArc(withCenter: CGPoint(x: w-50, y: h2), radius: 50, startAngle: .pi*1.5, endAngle:.pi*2 , clockwise: true)
        path1.addLine(to: CGPoint(x: w, y: h))
        path1.move(to: CGPoint(x: 0, y: h))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path1.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        //shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 0.0
        view.layer.addSublayer(shapeLayer)
        
        let gradientLayer2: CAGradientLayer = CAGradientLayer()
        gradientLayer2.colors = gradientColors
        gradientLayer2.frame = CGRect(x:w/2 - 120, y:0.75*h - 120, width:240, height:240)
        view.layer.addSublayer(gradientLayer2)

        let path2 = UIBezierPath()
        path2.addArc(withCenter: CGPoint(x: w/2, y: 0.75*h), radius: 100, startAngle: 0, endAngle: .pi*2, clockwise: true)
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.white.cgColor
        shapeLayer2.strokeColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 20.0
        view.layer.addSublayer(shapeLayer2)

    }
    
    
}
