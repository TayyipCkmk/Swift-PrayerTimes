//
//  PrayerTimesViewController.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 13.09.2021.
//

import UIKit

class PrayerTimesViewController: UIViewController {
    
    var ilceId: String!
    var timesList = [PrayerTimes]()
    var date = Date()
    var calendar = Calendar.current

    @IBOutlet weak var hicriLabel: UILabel!
    @IBOutlet weak var gunDogumLabel: UILabel!
    @IBOutlet weak var gunBatimLabel: UILabel!
    @IBOutlet weak var imsakLabel: UILabel!
    @IBOutlet weak var gunesLabel: UILabel!
    @IBOutlet weak var ogleLabel: UILabel!
    @IBOutlet weak var ikindiLabel: UILabel!
    @IBOutlet weak var aksamLabel: UILabel!
    @IBOutlet weak var yatsiLabel: UILabel!
    @IBOutlet weak var timeView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = Service(baseUrl: "https://ezanvakti.herokuapp.com/")
            service.getAllCitys(endPoint: "vakitler/" + ilceId, apiLink: [PrayerTimes]())
            service.timescompletionHandler { [weak self] (timesList, status, message) in
            if status {
                guard let self = self else {return}
                guard let _timesList = timesList else {return}
                self.timesList = _timesList
                //self.prayerTimesTableView.reloadData()
                self.prayerTimesScreenImages()
                self.prayerTimesScreenItems()
            }
        }
    }
    func prayerTimesScreenItems() {
        hicriLabel.text = timesList[0].hicriTarihUzun
        hicriLabel.layer.masksToBounds = true
        hicriLabel.layer.cornerRadius = 30
        
        gunDogumLabel.text = timesList[0].gunesDogus
        gunDogumLabel.layer.masksToBounds = true
        gunDogumLabel.layer.cornerRadius = 30
        
        gunBatimLabel.text = timesList[0].gunesBatis
        gunBatimLabel.layer.masksToBounds = true
        gunBatimLabel.layer.cornerRadius = 30
        
        imsakLabel.text = "İmsak : \(timesList[0].imsak)"
        imsakLabel.layer.masksToBounds = true
        imsakLabel.layer.cornerRadius = 30
        
        gunesLabel.text = "Güneş : \(timesList[0].gunes)"
        gunesLabel.layer.masksToBounds = true
        gunesLabel.layer.cornerRadius = 30
        
        ogleLabel.text = "Öğle : \(timesList[0].ogle)"
        ogleLabel.layer.masksToBounds = true
        ogleLabel.layer.cornerRadius = 30
        
        ikindiLabel.text = "İkindi : \(timesList[0].ikindi)"
        ikindiLabel.layer.masksToBounds = true
        ikindiLabel.layer.cornerRadius = 30
        
        aksamLabel.text = "Akşam : \(timesList[0].aksam)"
        aksamLabel.layer.masksToBounds = true
        aksamLabel.layer.cornerRadius = 30
        
        yatsiLabel.text = "Yatsı : \(timesList[0].yatsi)"
        yatsiLabel.layer.masksToBounds = true
        yatsiLabel.layer.cornerRadius = 30
    }
    func prayerTimesScreenImages() {
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let hours = "\(hour):\(minute)"
    
        if (hours < timesList[0].imsak) {
            timeView.image = UIImage(named: "yatsi")
        }else if (hours.description < timesList[0].gunes) {
            timeView.image = UIImage(named: "gunes")
        }else if (hours.description < timesList[0].ogle) {
            timeView.image = UIImage(named: "sabah")
        }else if (hours.description < timesList[0].ikindi) {
            timeView.image = UIImage(named: "ogle")
        }else if (hours.description < timesList[0].aksam) {
            timeView.image = UIImage(named: "ikindi")
        }else if (hours.description < timesList[0].yatsi) {
            timeView.image = UIImage(named: "aksam")
        }else if (hours.description > timesList[0].yatsi) {
            timeView.image = UIImage(named: "yatsi")
        }
    }
}
