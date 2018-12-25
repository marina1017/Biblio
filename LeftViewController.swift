//
//  LeftViewController.swift
//  Biblio
//
//  Created by nakagawa on 2018/12/24.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import SnapKit

class LeftViewController: UIViewController {

    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    let items = ["Biblio","ヘルプ","ご意見・ご要望"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.addTableViewToView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addTableViewToView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.darkGray
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension LeftViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.layoutMargins = .zero
        cell.textLabel?.text = self.items[indexPath.row]

        return cell
    }


}

extension LeftViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected! \(self.items[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

