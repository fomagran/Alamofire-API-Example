//
//  TestViewController.swift
//  Alamofire API Example
//
//  Created by Fomagran on 2021/09/13.
//

import UIKit
import Alamofire

class TestViewController: UIViewController {

    let baseURL = URL(string: "https://kox947ka1a.execute-api.ap-northeast-2.amazonaws.com/prod/users/start")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header1 = HTTPHeader(name: "X-Auth-Token", value: "8c703b8d4ff5c42c744f8e65f839acb6")
        let header2 = HTTPHeader(name: "Content-Type", value: "application/json")
        let headers = HTTPHeaders([header1,header2])
        
        AF.request(baseURL,method: .post,parameters:["problem": 1],encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                print(response)
            }
    }
}
