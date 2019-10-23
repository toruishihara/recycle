//
//  WalletTableViewCell.swift
//  recycle
//
//  Created by TORU ISHIHARA on 10/9/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class CoinTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Cell init \(String(describing: reuseIdentifier))")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coinImage: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        return view
    }()

    
    let coinLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 20, width: 200, height: 50))
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 32)
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinLabel2: UILabel = {
        let label2 = UILabel(frame: CGRect(x: 200, y: 30, width: 150, height:40))
        label2.textColor = UIColor.black
        label2.font = UIFont.boldSystemFont(ofSize: 16)
        label2.backgroundColor = .lightGray
        label2.textAlignment = .center
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label2
    }()

    func setupView() {
        print("setupView")
        addSubview(cellView)
        cellView.addSubview(coinImage)
        cellView.addSubview(coinLabel)
        cellView.addSubview(coinLabel2)
        self.selectionStyle = .none
        
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        //coinLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //coinLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //coinLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        //coinLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }

}
