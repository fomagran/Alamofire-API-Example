import UIKit
import Alamofire
import CoreLocation

let OPEN_API_KEY = "SKes8Td%2BSbmCfxyHPQdybDO7YRpm3ouk%2B0Ml%2FyzBaZRZLl2d9i7F8YwfD6gSA0yEFdnbcdlQ%2B2PLI6VHGLbuMA%3D%3D"

let TOTAL_APT_CODE_URL = "http://apis.data.go.kr/1613000/AptListService1/getTotalAptList?serviceKey=\(OPEN_API_KEY)&pageNo=1&numOfRows=1"

let TOTAL_API_INFO_URL = "http://apis.data.go.kr/1611000/AptBasisInfoService/getAphusBassInfo?serviceKey=\(OPEN_API_KEY)&kaptCode="


func addressToCoordinate(address:String) {
    let geoCoder = CLGeocoder()
       geoCoder.geocodeAddressString(address) { (placemarks, error) in
           guard
               let placemarks = placemarks,
               let location = placemarks.first?.location
           else {
                print("No Location")
               return
           }
        print(location.coordinate)
       }
}

if let path = Bundle.main.path(forResource: "아파트 정보", ofType: "txt") {
    do {
        print("?")
        let data = try String(contentsOfFile: path, encoding: .utf8)
        let myStrings = data.components(separatedBy: .newlines)
        
        loop(str:myStrings,times:myStrings.count-1)

    } catch {
        print(error)
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

addressToCoordinate(address: "서울특별시 마포구 성산동 631-5")
