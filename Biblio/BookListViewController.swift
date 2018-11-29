//
//  ViewController.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/29.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SnapKit

class BookListViewController: UIViewController {

    var bannerView: GADBannerView = {
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        return bannerView
    }()
    var tableView: UITableView!

    let items = ["Apple","Banana","Orange"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //広告バナー
        addBannerViewToView(bannerView)
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        //テーブルビュー
        self.tableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            self.view.addSubview(tableView)
            return tableView
        }()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.bannerView.snp.top)
        }



    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        self.bannerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }


}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected! \(self.items[indexPath.row])")
    }

}

extension BookListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")

        cell.textLabel?.text = self.items[indexPath.row]

        return cell
    }
}
