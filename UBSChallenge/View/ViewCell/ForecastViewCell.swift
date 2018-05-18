//
//  ForecastViewCell.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ForecastHeaderViewCell: UITableViewCell {
    static let identifier = "headerCell"
    @IBOutlet weak var title: UILabel!
    
    func setup(date: String) {
        title.text = date
    }
}


class ForecastViewCell: UITableViewCell {
    static let identifier = "cell"
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func setup(forecastItem: ForecastItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a".lowercased()
        time.text = dateFormatter.string(from: forecastItem.datetime)
        temp.text = "\(Int(forecastItem.main.temp))° F"
        max.text = "\(Int(forecastItem.main.tempMax))° F"
        min.text = "\(Int(forecastItem.main.tempMin))° F"
        setIconImage(iconCode: forecastItem.weather.first?.icon)
    }
    
    func setIconImage(iconCode:String?) {
        guard let iconCode = iconCode else { return }
        guard let url = URL(string: "http://openweathermap.org/img/w/\(iconCode).png") else { return }
        icon.sd_setImage(with: url, completed: nil)
    }
}
