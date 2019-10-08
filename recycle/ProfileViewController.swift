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
        let face_y:CGFloat = 0.05
        let circle_y:CGFloat = 0.72
        
        let topColor = UIColor(red:0.54, green:0.90, blue:0.74, alpha:1)
        let bottomColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = CGRect(x:0, y:0, width:w, height:circle_y * h)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        var imageView : UIImageView
        imageView  = UIImageView()
        imageView.image = UIImage(named:"face")
        imageView.frame = CGRect(x: (w-200)/2, y: h * face_y, width: 200, height: 200)
        self.view.addSubview(imageView)
        
        let label0 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 30))
        label0.center = CGPoint(x: w/2, y: h * face_y + 200 + 20)
        label0.textAlignment = .center
        label0.textColor = UIColor.white
        label0.font = UIFont.boldSystemFont(ofSize: 30.0)
        label0.text = "John Void"
        self.view.addSubview(label0)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label1.center = CGPoint(x: w/2, y: h * face_y + 200 + 50)
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        label1.text = "Total number of bottles recycled : 100"
        self.view.addSubview(label1)

        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label2.center = CGPoint(x: w/2, y: h * face_y + 200 + 70)
        label2.textAlignment = .center
        label2.textColor = UIColor.white
        label2.text = "Total amount of AMT earned in life : 500"
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
        gradientLayer2.frame = CGRect(x:w/2 - 120, y: circle_y * h - 120, width:240, height:240)
        view.layer.addSublayer(gradientLayer2)

        let path2 = UIBezierPath()
        path2.addArc(withCenter: CGPoint(x: w/2, y: circle_y * h), radius: 100, startAngle: 0, endAngle: .pi*2, clockwise: true)
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.white.cgColor
        shapeLayer2.strokeColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 20.0
        view.layer.addSublayer(shapeLayer2)
        
        let path11 = UIBezierPath() // circle background left
        path11.move(to: CGPoint(x: w/2 - 120, y: circle_y * h - 120 - 1))
        path11.addLine(to: CGPoint(x: w/2, y: circle_y * h - 120 - 1))
        path11.addArc(withCenter: CGPoint(x: w/2, y: circle_y * h), radius: 120, startAngle: -.pi*0.5, endAngle: -.pi*1.5, clockwise: false)
        path11.addLine(to: CGPoint(x: w/2 - 120, y: circle_y * h + 120))
        path11.addLine(to: CGPoint(x: w/2 - 120, y: circle_y * h - 120 - 1))
        let shapeLayer11 = CAShapeLayer()
        shapeLayer11.path = path11.cgPath
        shapeLayer11.fillColor = UIColor.white.cgColor
        shapeLayer11.lineWidth = 0.0
        view.layer.addSublayer(shapeLayer11)

        let path12 = UIBezierPath() // circle background right
        path12.move(to: CGPoint(x: w/2 + 120, y: circle_y * h - 120 - 1))
        path12.addLine(to: CGPoint(x: w/2, y: circle_y * h - 120 - 1))
        path12.addArc(withCenter: CGPoint(x: w/2, y: circle_y * h), radius: 120, startAngle: -.pi*0.5, endAngle: .pi*0.5, clockwise: true)
        path12.addLine(to: CGPoint(x: w/2 + 120, y: circle_y * h + 120))
        path12.addLine(to: CGPoint(x: w/2 + 120, y: circle_y * h - 120 - 1))
        let shapeLayer12 = CAShapeLayer()
        shapeLayer12.path = path12.cgPath
        shapeLayer12.fillColor = UIColor.white.cgColor
        shapeLayer12.lineWidth = 0.0
        view.layer.addSublayer(shapeLayer12)

        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label3.center = CGPoint(x: w/2, y: h * circle_y - 35)
        label3.textAlignment = .center
        label3.textColor = UIColor.gray
        label3.font = UIFont.boldSystemFont(ofSize: 10.0)
        label3.text = "AMT balance"
        self.view.addSubview(label3)

        let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 51))
        label4.center = CGPoint(x: w/2, y: h * circle_y)
        label4.textAlignment = .center
        label4.textColor = UIColor.black
        label4.font = UIFont.boldSystemFont(ofSize: 50.0)
        label4.text = "300"
        self.view.addSubview(label4)
        
        let label5 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label5.center = CGPoint(x: w/2, y: h * circle_y + 50)
        label5.textAlignment = .center
        label5.textColor = UIColor.gray
        label5.font = UIFont.boldSystemFont(ofSize: 20.0)
        label5.text = "AMT"
        self.view.addSubview(label5)


    }
    
    
}
