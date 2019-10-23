//
//  Coin.swift
//  recycle
//
//  Created by TORU ISHIHARA on 10/22/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import Foundation

class Coin {
    
    //MARK: Properties
    
    var coinId: String
    var owner: String
    var coinType: String?
    var value: String?
    var coinState: String?
    var coinSponsorId: String?
    var coinDesignId: String?
    
    //MARK: Initialization
    
    init?(json: Dictionary<String,Any>) {
        self.coinId = json["coinId"]! as! String
        let str:String = json["owner"]! as! String
        self.owner = String(str.suffix(6))
        self.coinType = (json["coinType"] as! String)
        self.value = (json["value"] as! String)
        self.coinState = (json["coinState"] as! String)
        self.coinSponsorId = (json["coinSponsorId"] as! String)
        self.coinDesignId = (json["coinDesignId"] as! String)
    }
    
    func GetJson() -> String {
        var ret:String = "{"
        ret += "  \"$class\": \"com.alchemistmaterial.test.AlchemistCoin\","
        ret += "  \"coinId\": \"\(coinId)\","
        ret += "  \"owner\": \"resource:com.alchemistmaterial.test.ProgramParticipant#\(owner)\","
        ret += "  \"coinType\": \"\(coinType!)\","
        ret += "  \"value\": \"\(value!)\","
        ret += "  \"coinSponsorId\": \"\(coinSponsorId!)\","
        ret += "  \"coinDesignId\": \"\(coinDesignId!)\","
        ret += "}"
        return ret
    }
}
