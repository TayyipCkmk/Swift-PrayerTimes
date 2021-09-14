//
//  TownsViewController.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 8.09.2021.
//

import UIKit

class TownsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var townList = [Towns]()
    var sehirId: String!
    
    @IBOutlet weak var townsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        townsTableView.delegate = self
        townsTableView.dataSource = self
        let service = Service(baseUrl: "https://ezanvakti.herokuapp.com/")
        service.getAllCitys(endPoint: "ilceler/" + sehirId, apiLink: [Towns]())
        service.towncompletionHandler { [weak self] (townList, status, message) in
            if status {
                guard let self = self else {return}
                guard let _townList = townList else {return}
                self.townList = _townList
                self.townsTableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        townList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let towncell = townsTableView.dequeueReusableCell(withIdentifier: "towncell")!
        towncell.textLabel?.text = townList[indexPath.row].ilceAdi
        return towncell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timesStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ilceId = timesStoryboard.instantiateViewController(withIdentifier: "timesVc") as! PrayerTimesViewController
            ilceId.ilceId = townList[indexPath.row].ilceID
        self.navigationController?.pushViewController(ilceId, animated: true)
        print(townList[indexPath.row].ilceID)
    }
    
}
