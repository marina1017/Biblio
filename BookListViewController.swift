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

    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    var items = ["Apple","Banana","Orange","Orange","Orange","Orange"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "読書リスト"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.leftBarBtnClicked))
        //広告バナー
        self.addBannerViewToView()
        //TableView
        self.addTableViewToView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    func addBannerViewToView() {
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func addTableViewToView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //セルの登録
        self.tableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.bannerView.snp.top)
        }
    }

    //左側のボタンが押されたら呼ばれる
    @objc func leftBarBtnClicked(){
        print("leftBarBtnClicked")
    }


}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected! \(self.items[indexPath.row])")
        self.tableView.deselectRow(at: indexPath, animated: true)
        let bookViewController = BookViewController()
        self.navigationController?.pushViewController(bookViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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

        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BookCell.self), for: indexPath) as? BookCell else {
            return UITableViewCell(frame: .zero)
        }
        cell.accessoryType = .disclosureIndicator

        //dummy text
        var dummyString = "01234567890"
        for i in 0...indexPath.row {
            dummyString += dummyString
        }
        //set text
        cell.bookNameLabel.text = "index : \(indexPath.row), dummyString : \(dummyString)"
        //セルの高さ自動計算に必要
        cell.layoutIfNeeded()

        return cell
    }

}
