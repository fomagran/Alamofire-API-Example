//
//  ViewController.swift
//  Alamofire API Example
//
//  Created by Fomagran on 2021/01/27.
//

import UIKit
import Alamofire
import SwiftyXMLParser
import CoreLocation

/*
 반드시 info.plist에 추가해줄것
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
    
    let apikey = "lYOILTwXfNjbdoXx6QKw"
    let secretkey = "Xlub5gw8p8YBWnpeADC5BvwCmwxJOWURsEKhmLUj"
    
    var parser: XMLParser!
    var code = [String]()
    var bool = true
    var aptArr = [String]()
    var info = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode"
    
    
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: apikey)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: secretkey)
        let headers = HTTPHeaders([header1,header2])
      
        AF.request(url, method: .get,headers: headers).validate()
            .responseString { [self] response in
                //if case success
                switch response.result {
                case .success:

                    print(response.result)

                case .failure(_):
                    print(response.result)
                }
            }

          
        
    
        
//        getAptCodeData(code: url)
//        addressToCoordinate(address: "서울특별시 노원구 하계동 288 하계2차현대아파트")
    
        let path = Bundle.main.path(forResource: "아파트 위도경도", ofType: "txt")
        print(path)
    
        if let path = Bundle.main.path(forResource: "아파트 위도경도", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                for str in myStrings {
                    if !str.contains("NSLocale") {
//                        print(str)
                    }
                }


//                loop(str: myStrings, times: myStrings.count)

            } catch {
                print(error)
            }
        }
        
    }
    
    func loop(str:[String],times: Int) {
        var i = 0

        func nextIteration() {
            if i < times {

                i += 1
                
                let address = str[i].components(separatedBy: ",").first!
                addressToCoordinate(address: address)

                DispatchQueue.main.asyncAfter(deadline: .now() +  1) {
                    nextIteration()
                }
            }
        }
        nextIteration()
    }
    
    func addressToCoordinate(address:String) {
        let geoCoder = CLGeocoder()
           geoCoder.geocodeAddressString(address) { (placemarks, error) in
               guard
                   let placemarks = placemarks,
                   let location = placemarks.first?.location
               else {
                    print("no location")
                   return
               }
            print(address,",",location.coordinate.latitude,",",location.coordinate.longitude)
           }
    }
    
    func getAptCodeData(code:String) {
        let url = URL(string: code)!
      
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "kaptAddr" || elementName == "kaptName" {
           bool = true
        }else {
            bool = false
        }

       
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "kaptAddr" || elementName == "kaptName" {
          
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
            if bool {
                if info.isEmpty {
                    info = string
                }else {
                    info += ",\(string)"
                    print(info)
                }
            }
    }
    
    

}

extension ViewController:XMLParserDelegate {
    
}



