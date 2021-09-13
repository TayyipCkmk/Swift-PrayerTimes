//
//  Towns.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 13.09.2021.
//

import Foundation

struct Towns: Codable {
    let ilceAdi, ilceAdiEn, ilceID: String

    enum CodingKeys: String, CodingKey {
        case ilceAdi = "IlceAdi"
        case ilceAdiEn = "IlceAdiEn"
        case ilceID = "IlceID"
    }
}
