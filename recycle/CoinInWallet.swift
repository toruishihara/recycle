//
//  Coin.swift
//  recycle
//
//  Created by TORU ISHIHARA on 10/9/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

class CoinInWallet {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var num: Int64
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, num: Int64) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.num = num
    }
}
