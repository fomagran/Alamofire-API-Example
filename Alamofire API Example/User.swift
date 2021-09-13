//
//  User.swift
//  Alamofire API Example
//
//  Created by Fomagran on 2021/02/22.
//

import Foundation

struct User :Codable{
    var phoneNumber:String = ""
    var email:String = ""
    var account:String = ""
    var regionId:Int = 0
    
    init(phoneNumber:String,account:String) {
        self.phoneNumber = phoneNumber
        self.email = "fomagran6@naver.com"
        self.account = account
        self.regionId = 1
    }
}


extension User {
    func toJSON() -> Dictionary<String, Any> {
        return ["phone_number" : self.phoneNumber
                ,"email": self.email,
                "account" : self.account,
                "region_id" :  self.regionId] as [String: Any]
    }
}
