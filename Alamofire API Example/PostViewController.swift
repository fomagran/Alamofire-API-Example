//
//  PostViewController.swift
//  Alamofire API Example
//
//  Created by Fomagran on 2021/02/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostViewController: UIViewController {
    
    let path =  "http://ec2-52-78-157-207.ap-northeast-2.compute.amazonaws.com:8080/api/user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
       
    }
    
    
    
    private func get() {
        AF.request(path).responseJSON { response in
            let result = response.result
            switch result {
            case .success(let value as [String:Any]):
                let json = JSON(value)
                let data = json["data"]
                print(data[0])
            case .failure(let error):
                print(error.errorDescription ?? "")
            default :
                fatalError()
            }
        }
    }
    
    private func post() {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = User().toJSON()
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        AF.request(request).responseJSON { (response) in
            print(response)
        }
    }
    
    
}
