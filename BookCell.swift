//
//  File.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/30.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import SnapKit

class BookCell : UITableViewCell {
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Swiftの本"
        label.font = Appearance.font.label(15, weight: .semibold)
        label.textColor = Appearance.color.font
        return label
    }()

    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "10月10日まで"
        label.font = Appearance.font.label(10, weight: .light)
        label.textColor = Appearance.color.font
        return label
    }()

    let progressView: UIView = {
        let progressView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressView.backgroundColor = UIColor.red

        return progressView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.addSubview(self.bookNameLabel)
        self.addSubview(self.deadlineLabel)
        self.addSubview(self.progressView)
    }


    override func updateConstraints() {

        //これは最後によぶ
        super.updateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutBookNameLabel()
        self.layoutDeadlineLabel()

        self.layoutProgressView()
    }

    private func layoutBookNameLabel() {
        self.bookNameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(Appearance.size.small)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview()
            make.bottom.equalTo(self.deadlineLabel.snp.top)
        }
    }

    private func layoutDeadlineLabel() {
        self.deadlineLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.bookNameLabel.snp.bottom)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview()
            make.bottom.equalTo(self.progressView.snp.top)
        }
    }

    private func layoutProgressView() {
        self.progressView.snp.makeConstraints{ make in
            //make.top.equalTo(self.deadlineLabel.snp.bottom)
            make.height.equalTo(Appearance.size.default)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(Appearance.size.small)
        }
    }
}
