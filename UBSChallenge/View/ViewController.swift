//
//  ViewController.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataLoading: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    let viewModel = ForecastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForecast()
    }
    
    /**
     Setups the observables for the table view and activity indicator
     */
    func setupForecast() {
        viewModel.isDataLoading.asObservable().subscribe(onNext: { isDataLoading in
            DispatchQueue.main.async { [unowned self] in
                if isDataLoading {
                    self.dataLoading.startAnimating()
                    self.dataLoading.isHidden = false
                } else {
                    self.dataLoading.stopAnimating()
                    self.dataLoading.isHidden = true
                }
            }
        }).disposed(by: disposeBag)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.forecast.asObservable().subscribe(onNext: { _ in
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
                self.cityName.text = self.viewModel.city.value.name
                let latestTemp = self.viewModel.forecast.value.first?.list.first?.main.temp ?? 0
                self.cityTemp.text = "\(Int(latestTemp))° F"
            }
        }).disposed(by: disposeBag)
        viewModel.fetchData()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.forecast.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let _cell = tableView.dequeueReusableCell(withIdentifier: ForecastHeaderViewCell.identifier)
        guard let cell = _cell as? ForecastHeaderViewCell else { return _cell }
        cell.setup(date: viewModel.forecast.value[section].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecast.value[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _cell = tableView.dequeueReusableCell(withIdentifier: ForecastViewCell.identifier)
        guard let cell = _cell as? ForecastViewCell else { return _cell! }
        cell.setup(forecastItem: viewModel.forecast.value[indexPath.section].list[indexPath.row])
        return cell
    }
}
