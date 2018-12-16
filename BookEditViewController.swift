//
//  BookViewControlelr.swift
//  Biblio
//
//  Created by nakagawa on 2018/12/16.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import fluid_slider
import SnapKit

class BookEditViewController: UIViewController {
    let bookEditView: BookEditView = {
        let bookEditView = BookEditView()
        return bookEditView
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(self.bookEditView)
        self.bookEditView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
