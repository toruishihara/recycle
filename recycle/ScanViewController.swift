//
//  SecondViewController.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import AVFoundation
import UIKit

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var coinView: UIImageView!
    var label1:UILabel!
    var shapeLayer1:CAShapeLayer!
    var timer: Timer!
    var coinNo: Int!
    var url = URL(string: "https://www.coke.com")
    var Count:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        captureSession = AVCaptureSession()
        setPreviewLayer()
        startCaptureSession()
    }
    
    func setPreviewLayer() {
        let w = self.view.frame.width
        //let h = self.view.frame.height

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        previewLayer.frame = CGRect(x: (w-200)/2, y: (w-200)/2, width: 200, height: 200)
        previewLayer.videoGravity = .resizeAspectFill
        
        let path1 = UIBezierPath()
        let near = w/2 - 110
        let far = w/2 + 110
        path1.move(to: CGPoint(x: near-2, y: near))
        path1.addLine(to: CGPoint(x: far, y: near))
        path1.addLine(to: CGPoint(x: far, y: far))
        path1.addLine(to: CGPoint(x: near, y: far))
        path1.addLine(to: CGPoint(x: near, y: near-2))
        shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.strokeColor = UIColor.darkGray.cgColor
        shapeLayer1.lineDashPattern = [57, 110, 110, 110, 110, 110, 110, 110, 110, 110]
        shapeLayer1.lineWidth = 4.0

        label1 = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 21))
        label1.center = CGPoint(x: w/2, y: far + 30)
        label1.textAlignment = .center
        label1.textColor = UIColor.black
        label1.text = "Scan QR-Code on the recycle box"
    }
    
    func startCaptureSession() {
        coinNo = Count//Int.random(in: 1..<8)
        Count = Count + 1
        if (Count >= 8) {
            Count = 1
        }
        coinView = UIImageView(image: UIImage(named: String(format: "D%02d", coinNo)))
        coinView.contentMode = .scaleAspectFill
        coinView.frame = CGRect(x: 0, y: 0, width: 220, height: 220)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.coinTouchAction))
        self.view.addGestureRecognizer(gesture)
            
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(previewLayer)
        self.view.addSubview(label1)

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        captureSession.startRunning()
    }

    func failed() {
        //let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        //ac.addAction(UIAlertAction(title: "OK", style: .default))
        //present(ac, animated: true)
        print("failed")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

    @objc func coinTouchAction(sender : UITapGestureRecognizer) {
        // Do what you want
        print("touch")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }

    func found(code: String) {
        print(code)
        previewLayer.removeFromSuperlayer()
        shapeLayer1.removeFromSuperlayer()
        label1.removeFromSuperview()
        if (coinNo == 5) {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "firework")!)
        }
        if (coinNo == 2) {
            url = URL(string: "https://www.alchemist-material.com")
        } else if (coinNo == 3) {
            url = URL(string:"https://www.ac-illust.com")
        } else if (coinNo == 4) {
            url = URL(string: "https://www.starbucks.com")
        } else if (coinNo == 5) {  // AKB
            url = URL(string: "https://www.youtube.com/watch?v=0pKfxbCHLoU")
       } else if (coinNo == 6) {
           url = URL(string: "https://www.youtube.com/channel/UC6IMGCz0Pjwt2icerqPIuZg") // Oretachi channel
        } else if (coinNo == 7) {
            url = URL(string: "https://www.youtube.com/watch?v=GM3SIBr7NvI&t=34s") // hikakin
        } else {
            url = URL(string: "https://www.coke.com")
        }
        
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(nextScan), userInfo: nil, repeats: false)

        self.view.addSubview(self.coinView)
        self.coinView.center = self.view.center

        if (coinNo == 3) {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextAnimetion), userInfo: nil, repeats: false)
        }

        UIView.animate(withDuration: 2.0, delay: 0.0, options:[.repeat, .autoreverse], animations: {
            self.coinView.center.y += 200.0
        }, completion: nil)
    }

    @objc func nextScan()
    {
        print("nextScan")
        self.coinView.removeFromSuperview()
        view.backgroundColor = UIColor.white
        captureSession = AVCaptureSession()
        setPreviewLayer()
        startCaptureSession()

        print("nextScan end")
    }
    
    @objc func nextAnimetion()
    {
        self.coinView.image = UIImage(named: "D03b")
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
