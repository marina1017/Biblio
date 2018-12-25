//
//  FormViewController.swift
//  Biblio
//
//  Created by 中川万莉奈 on 2018/12/26.
//  Copyright © 2018年 nakagawa. All rights reserved.
//


import UIKit
import SnapKit

class FormViewController: UIViewController {
    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    let items = ["Biblio","ヘルプ","ご意見・ご要望"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        self.addTableViewToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTableViewToView() {
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
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
