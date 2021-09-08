//
//  Service.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 8.09.2021.
//

import Foundation
import Alamofire

class Service {
    var baseUrl = ""
    typealias cityListCallBack = (_ cityList:[Locations]?,_ status:Bool, _ message:String) -> Void
    var callBack: cityListCallBack?
    
    init(baseUrl: String) {
          self.baseUrl = baseUrl
    }
    func getAllCitys(endPoint: String) {
        AF.request(self.baseUrl + endPoint).responseDecodable(of: [Locations].self) { (response) in
            guard let locations = response.value else { return }
            self.callBack?(locations,true,"")
        }
    }
    func completionHandler(callBack: @escaping cityListCallBack) {
        self.callBack = callBack
    }
}

