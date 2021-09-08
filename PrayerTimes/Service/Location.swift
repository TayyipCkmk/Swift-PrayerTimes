//
//  Location.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 8.09.2021.
//

import Foundation

struct Locations: Decodable {
    let sehirAdi, sehirAdiEn, sehirID: String

    enum CodingKeys: String, CodingKey {
        case sehirAdi = "SehirAdi"
        case sehirAdiEn = "SehirAdiEn"
        case sehirID = "SehirID"
    }
}
