//
//  TimesTableViewCell.swift
//  PrayerTimes
//
//  Created by Tayyip Çakmak on 13.09.2021.
//

import UIKit

class TimesTableViewCell: UITableViewCell {

    @IBOutlet weak var prayerTimeView: UIImageView!
    @IBOutlet weak var prayerTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
