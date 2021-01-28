//
//  ViewController.swift
//  Alamofire API Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import Alamofire
import SwiftyXMLParser

/*반드시 info.plist에 추가해줄것
 <key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    <key>NSExceptionDomains</key>
    <dict>
        <key>yourdomain.com</key>
        <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
            <false/>
        </dict>
   </dict>
</dict>
 */

class ViewController: UIViewController {
    
    
    var codes = [String]()
    var fails = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...1000 {
            getAptCodeData(n: i)
        }
        
    }
    
    func getAptCodeData(n:Int) {
        let url =   URL(string: "http://apis.data.go.kr/1613000/AptListService1/getTotalAptList?serviceKey=\(OPEN_API_APTINFO_KEY)&pageNo=\(n)&numOfRows=1")!
        AF.request(url, method: .get).validate()
            .responseString { response in
                //if case success
                switch response.result {
                case .success:
                    let responseString = NSString(data: response.data!, encoding:
                                                    String.Encoding.utf8.rawValue )!
                    let xml = try! XML.parse(responseString as String)
                    
                    let kaptCode = xml["response","body","items","item","kaptCode"].text ?? ""
                    let kaptName = xml["response","body","items","item","kaptName"].text ?? ""
    
                    self.codes.append("\(kaptCode): \(kaptName)")
                    print("\(kaptCode): \(kaptName)")
                    
                case .failure(_):
                    self.fails.append("fails")
                }
            }
    }
}
