//
//  PrayerTimes.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 13.09.2021.
//

import Foundation

struct PrayerTimes: Codable {
    let imsak, gunes, ogle, ikindi: String
    let aksam, yatsi, gunesBatis, gunesDogus: String
    let hicriTarihUzun, kibleSaati, miladiTarihKisa, miladiTarihUzun: String

    enum CodingKeys: String, CodingKey {
        case imsak = "Imsak"
        case gunes = "Gunes"
        case ogle = "Ogle"
        case ikindi = "Ikindi"
        case aksam = "Aksam"
        case yatsi = "Yatsi"
        case gunesBatis = "GunesBatis"
        case gunesDogus = "GunesDogus"
        case hicriTarihUzun = "HicriTarihUzun"
        case kibleSaati = "KibleSaati"
        case miladiTarihKisa = "MiladiTarihKisa"
        case miladiTarihUzun = "MiladiTarihUzun"
    }
}
