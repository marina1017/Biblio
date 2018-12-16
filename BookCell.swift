//
//  File.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/30.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import SnapKit
import fluid_slider
import WOWMarkSlider

class BookCell : UITableViewCell {
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Swiftの本"
        label.font = Appearance.font.label(15, weight: .semibold)
        label.textColor = Appearance.color.font
        label.numberOfLines = 0
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
        let progressView = UIView()
        //progressView.backgroundColor = UIColor.red
        progressView.sizeToFit()
        return progressView
    }()

    let slider: Slider = {
        let slider = Slider()
        let textStringAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 1),
            .font : UIFont.systemFont(ofSize: 10.0)
        ]
        let labelStringAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.boldSystemFont(ofSize: 10.0)
        ]
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: textStringAttributes)
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelStringAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "500", attributes: labelStringAttributes))
        slider.fraction = 0.5
        slider.isAnimationEnabled = false
        slider.isEnabled = false
        slider.contentViewColor = UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 1)
        slider.valueViewColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

//    let slider: WOWMarkSlider = {
//        let slider = WOWMarkSlider()
//        slider.markColor = UIColor.red
//        slider.markWidth = 2.0
//        slider.markPositions = [30, 50, 80]
//        slider.lineCap = .square
//        slider.height = 7.0
//        return slider
//    }()


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
        self.progressView.addSubview(self.slider)
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
        self.layoutSlider()
    }

    private func layoutBookNameLabel() {
        self.bookNameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(Appearance.size.small)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.deadlineLabel.snp.top)
        }
    }

    private func layoutDeadlineLabel() {
        self.deadlineLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.bookNameLabel.snp.bottom)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.bottom.equalTo(self.progressView.snp.top)
        }
    }

    private func layoutProgressView() {
        self.progressView.snp.makeConstraints{ make in
            make.top.equalTo(self.deadlineLabel.snp.bottom)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalToSuperview().offset(-Appearance.size.small)
        }
    }

    private func layoutSlider() {
        self.slider.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(Appearance.size.small)
            make.height.equalTo(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
