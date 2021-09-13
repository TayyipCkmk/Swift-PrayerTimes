//
//  Service.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 8.09.2021.
//

import Foundation
import Alamofire
protocol ListenerProtocol: class {}
class Service {
    var baseUrl = ""

    typealias cityListCallBack = (_ cityList:[Locations]?,_ status:Bool, _ message:String) -> Void
    var callBack: cityListCallBack?
    
    typealias townListCallBack = (_ townList:[Towns]?,_ status:Bool, _ message:String) -> Void
    var towncallBack: townListCallBack?
    
    init(baseUrl: String) {
          self.baseUrl = baseUrl
    }
    func getAllCitys<T: Decodable >(endPoint: String, apiLink: T) {
        AF.request(self.baseUrl + endPoint).responseDecodable{ (response: AFDataResponse<T>) in
            guard let locations = response.value else { return }
            self.callBack?(locations as? [Locations],true,"")
            guard let townLocations = response.value else { return }
            self.towncallBack?(townLocations as? [Towns],true,"")
        }
    }
    func completionHandler(callBack: @escaping cityListCallBack) {
        self.callBack = callBack
    }
    func towncompletionHandler(towncallBack: @escaping townListCallBack) {
        self.towncallBack = towncallBack
    }
}

