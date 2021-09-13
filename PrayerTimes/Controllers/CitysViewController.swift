//
//  CitysViewController.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 8.09.2021.
//

import UIKit
import Alamofire

class CitysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var citysTableView: UITableView!
    var cityList = [Locations]()
    var townsCode: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        citysTableView.delegate = self
        citysTableView.dataSource = self
        let service = Service(baseUrl: "https://ezanvakti.herokuapp.com/")
        service.getAllCitys(endPoint: "sehirler/2", apiLink: [Locations]())
        service.completionHandler { [weak self] (cityList, status, message) in
            if status {
                guard let self = self else {return}
                guard let _cityList = cityList else {return}
                self.cityList = _cityList
                self.citysTableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citysTableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = cityList[indexPath.row].sehirAdi
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let townStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sehirId = townStoryboard.instantiateViewController(withIdentifier: "townVc") as! TownsViewController
            sehirId.sehirId = cityList[indexPath.row].sehirID
        self.navigationController?.pushViewController(sehirId, animated: true)
        print(cityList[indexPath.row].sehirID)
    }
}
