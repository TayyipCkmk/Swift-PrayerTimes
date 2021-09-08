//
//  ViewController.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 7.09.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 25
    }
    @IBAction func loginButtonFunc(_ sender: UIButton) {
        self.performSegue(withIdentifier: "citysVc", sender: nil)
    }
}

