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
    var countTimerImsak:Timer!
    var countTimerSabah:Timer!
    var countTimerOgle:Timer!
    var countTimerIkindi:Timer!
    var countTimerAksam:Timer!
    var countTimerYatsi:Timer!
    
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

    @IBOutlet weak var imsakKalanLabel: UILabel!
    @IBOutlet weak var gunesKalanLabel: UILabel!
    @IBOutlet weak var ogleKalanLabel: UILabel!
    @IBOutlet weak var ikindiKalanLabel: UILabel!
    @IBOutlet weak var aksamKalanLabel: UILabel!
    @IBOutlet weak var yatsiKalanLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = Service(baseUrl: "https://ezanvakti.herokuapp.com/")
            service.getAllCitys(endPoint: "vakitler/" + ilceId, apiLink: [PrayerTimes]())
            service.timescompletionHandler { [weak self] (timesList, status, message) in
            if status {
                guard let self = self else {return}
                guard let _timesList = timesList else {return}
                self.timesList = _timesList
                self.prayerTimesScreenImages()
                self.prayerTimesScreenItems()
                self.prayerTimesScreenRemainder()
                //self.prayerTimeScreenCount()
                DispatchQueue.main.async { [self] in
                    self.countTimerImsak = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.prayerTimeScreenRemainderImsak), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.async { [self] in
                    self.countTimerSabah = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.prayerTimeScreenRemainderSabah), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.async { [self] in
                    self.countTimerOgle = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.prayerTimeScreenRemainderOgle), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.async { [self] in
                    self.countTimerIkindi = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.prayerTimeScreenRemainderIkindi), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.async { [self] in
                    self.countTimerAksam = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.prayerTimeScreenRemainderAksam), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.async { [self] in
                    self.countTimerYatsi = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.prayerTimeScreenRemainderYatsi), userInfo: nil, repeats: true)
                }

            }
        }
    }
    func prayerTimesScreenItems() {
        hicriLabel.text = timesList[0].hicriTarihUzun
        hicriLabel.layer.masksToBounds = true
        hicriLabel.layer.cornerRadius = 30
        
        gunDogumLabel.text = "Gün Doğum : \(timesList[0].gunesDogus)"
        gunDogumLabel.layer.masksToBounds = true
        gunDogumLabel.layer.cornerRadius = 30
        
        gunBatimLabel.text = "Gün Batım : \(timesList[0].gunesBatis)"
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
        //let second = calendar.component(.second, from: date)
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
    func prayerTimesScreenRemainder() {
        imsakKalanLabel.layer.masksToBounds = true
        imsakKalanLabel.layer.cornerRadius = 30
        
        gunesKalanLabel.layer.masksToBounds = true
        gunesKalanLabel.layer.cornerRadius = 30
        
        ogleKalanLabel.layer.masksToBounds = true
        ogleKalanLabel.layer.cornerRadius = 30
        
        ikindiKalanLabel.layer.masksToBounds = true
        ikindiKalanLabel.layer.cornerRadius = 30
        
        aksamKalanLabel.layer.masksToBounds = true
        aksamKalanLabel.layer.cornerRadius = 30
        
        yatsiKalanLabel.layer.masksToBounds = true
        yatsiKalanLabel.layer.cornerRadius = 30
    }
    
    @objc func prayerTimeScreenRemainderImsak() {
        let userCalendar = Calendar.current
        let newDate = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .second], from: newDate)
        let currentDate = userCalendar.date(from: components)!
    
        let remainderAksam = timesList[0].imsak
        let remainderAksamHour = Int(remainderAksam.prefix(2))
        let remainderAksamMin = Int(remainderAksam.suffix(2))

        var eventDateComponentsAksam = DateComponents()
        eventDateComponentsAksam.hour = remainderAksamHour
        eventDateComponentsAksam.minute = remainderAksamMin
        eventDateComponentsAksam.second = 00
        eventDateComponentsAksam.timeZone = TimeZone(abbreviation: "GMT+03:00")

        let eventDateAksam = userCalendar.date(from: eventDateComponentsAksam)!
        let timeLeftAksam = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: eventDateAksam)
        imsakKalanLabel.text = "Kalan: \(timeLeftAksam.hour!):\(timeLeftAksam.minute!):\(timeLeftAksam.second!) "
        endEventImsak(currentdate: currentDate, eventdate: eventDateAksam)
    }
    @objc func prayerTimeScreenRemainderSabah() {
        let userCalendar = Calendar.current
        let newDate = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .second], from: newDate)
        let currentDate = userCalendar.date(from: components)!
        //Aksam
        let remainderAksam = timesList[0].gunes
        let remainderAksamHour = Int(remainderAksam.prefix(2))
        let remainderAksamMin = Int(remainderAksam.suffix(2))

        var eventDateComponentsAksam = DateComponents()
        eventDateComponentsAksam.hour = remainderAksamHour
        eventDateComponentsAksam.minute = remainderAksamMin
        eventDateComponentsAksam.second = 00
        eventDateComponentsAksam.timeZone = TimeZone(abbreviation: "GMT+03:00")

        let eventDateAksam = userCalendar.date(from: eventDateComponentsAksam)!
        let timeLeftAksam = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: eventDateAksam)
        gunesKalanLabel.text = "Kalan: \(timeLeftAksam.hour!):\(timeLeftAksam.minute!):\(timeLeftAksam.second!) "
        endEventGunes(currentdate: currentDate, eventdate: eventDateAksam)
    }
    @objc func prayerTimeScreenRemainderOgle() {
        let userCalendar = Calendar.current
        let newDate = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .second], from: newDate)
        let currentDate = userCalendar.date(from: components)!
        //Aksam
        let remainderAksam = timesList[0].ogle
        let remainderAksamHour = Int(remainderAksam.prefix(2))
        let remainderAksamMin = Int(remainderAksam.suffix(2))

        var eventDateComponentsAksam = DateComponents()
        eventDateComponentsAksam.hour = remainderAksamHour
        eventDateComponentsAksam.minute = remainderAksamMin
        eventDateComponentsAksam.second = 00
        eventDateComponentsAksam.timeZone = TimeZone(abbreviation: "GMT+03:00")

        let eventDateAksam = userCalendar.date(from: eventDateComponentsAksam)!
        let timeLeftAksam = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: eventDateAksam)
        ogleKalanLabel.text = "Kalan: \(timeLeftAksam.hour!):\(timeLeftAksam.minute!):\(timeLeftAksam.second!) "
        endEventOgle(currentdate: currentDate, eventdate: eventDateAksam)
    }
    @objc func prayerTimeScreenRemainderIkindi() {
        let userCalendar = Calendar.current
        let newDate = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .second], from: newDate)
        let currentDate = userCalendar.date(from: components)!
        //Aksam
        let remainderAksam = timesList[0].ikindi
        let remainderAksamHour = Int(remainderAksam.prefix(2))
        let remainderAksamMin = Int(remainderAksam.suffix(2))

        var eventDateComponentsAksam = DateComponents()
        eventDateComponentsAksam.hour = remainderAksamHour
        eventDateComponentsAksam.minute = remainderAksamMin
        eventDateComponentsAksam.second = 00
        eventDateComponentsAksam.timeZone = TimeZone(abbreviation: "GMT+03:00")

        let eventDateAksam = userCalendar.date(from: eventDateComponentsAksam)!
        let timeLeftAksam = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: eventDateAksam)
        ikindiKalanLabel.text = "Kalan: \(timeLeftAksam.hour!):\(timeLeftAksam.minute!):\(timeLeftAksam.second!) "
        endEventIkindi(currentdate: currentDate, eventdate: eventDateAksam)
    }
    @objc func prayerTimeScreenRemainderAksam() {
        let userCalendar = Calendar.current
        let newDate = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .second], from: newDate)
        let currentDate = userCalendar.date(from: components)!
        //Aksam
        let remainderAksam = timesList[0].aksam
        let remainderAksamHour = Int(remainderAksam.prefix(2))
        let remainderAksamMin = Int(remainderAksam.suffix(2))

        var eventDateComponentsAksam = DateComponents()
        eventDateComponentsAksam.hour = remainderAksamHour
        eventDateComponentsAksam.minute = remainderAksamMin
        eventDateComponentsAksam.second = 00
        eventDateComponentsAksam.timeZone = TimeZone(abbreviation: "GMT+03:00")

        let eventDateAksam = userCalendar.date(from: eventDateComponentsAksam)!
        let timeLeftAksam = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: eventDateAksam)
        aksamKalanLabel.text = "Kalan: \(timeLeftAksam.hour!):\(timeLeftAksam.minute!):\(timeLeftAksam.second!) "
        endEventAksam(currentdate: currentDate, eventdate: eventDateAksam)
    }
    @objc func prayerTimeScreenRemainderYatsi() {
        let userCalendar = Calendar.current
        let newDate = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .second], from: newDate)
        let currentDate = userCalendar.date(from: components)!
        //Aksam
        let remainderAksam = timesList[0].yatsi
        let remainderAksamHour = Int(remainderAksam.prefix(2))
        let remainderAksamMin = Int(remainderAksam.suffix(2))

        var eventDateComponentsAksam = DateComponents()
        eventDateComponentsAksam.hour = remainderAksamHour
        eventDateComponentsAksam.minute = remainderAksamMin
        eventDateComponentsAksam.second = 00
        eventDateComponentsAksam.timeZone = TimeZone(abbreviation: "GMT+03:00")

        let eventDateAksam = userCalendar.date(from: eventDateComponentsAksam)!
        let timeLeftAksam = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: eventDateAksam)
        yatsiKalanLabel.text = "Kalan: \(timeLeftAksam.hour!):\(timeLeftAksam.minute!):\(timeLeftAksam.second!) "
        endEventYatsi(currentdate: currentDate, eventdate: eventDateAksam)
    }

    func endEventImsak(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            imsakKalanLabel.text = "Okundu."
            countTimerImsak.invalidate()
        }
    }
    func endEventGunes(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            gunesKalanLabel.text = "Okundu."
            countTimerSabah.invalidate()
        }
    }
    func endEventOgle(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            ogleKalanLabel.text = "Okundu."
            countTimerOgle.invalidate()
        }
    }
    func endEventIkindi(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            ikindiKalanLabel.text = "Okundu."
            countTimerIkindi.invalidate()
        }
    }
    func endEventAksam(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            aksamKalanLabel.text = "Okundu."
            countTimerAksam.invalidate()
        }
    }
    func endEventYatsi(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            yatsiKalanLabel.text = "Okundu."
            countTimerYatsi.invalidate()
        }
    }
}
