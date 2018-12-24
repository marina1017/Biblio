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
        label.text = "読了目標日10月10日"
        label.font = Appearance.font.label(10, weight: .light)
        label.textColor = Appearance.color.font
        return label
    }()

    let scheduleSuggestLabel: UILabel = {
        let label = UILabel()
        label.text = "本日５ｐ読めば目標を達成できます"
        label.font = Appearance.font.label(10, weight: .light)
        label.textColor = Appearance.color.font
        return label
    }()

    let slider: Slider = {
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
            //ここでは10
            return NSAttributedString(string: string, attributes: Appearance.attribute.textStringAttributes(10))
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: Appearance.attribute.labelStringAttributes(10)))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "500", attributes: Appearance.attribute.labelStringAttributes(10)))
        slider.fraction = 0.5
        slider.isAnimationEnabled = false
        slider.isEnabled = false
        slider.contentViewColor = Appearance.color.slider
        slider.valueViewColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
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
        self.addSubview(self.scheduleSuggestLabel)
        self.addSubview(self.slider)
    }

    override func updateConstraints() {

        //これは最後によぶ
        super.updateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutBookNameLabel()
        self.layoutDeadlineLabel()
        self.layoutScheduleSuggestLabel()
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
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.scheduleSuggestLabel.snp.top)
        }
    }

    private func layoutScheduleSuggestLabel() {
        self.scheduleSuggestLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.deadlineLabel.snp.bottom)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.slider.snp.top).offset(-Appearance.size.small)
        }
    }

    private func layoutSlider() {
        self.slider.snp.makeConstraints{ make in
            make.top.equalTo(self.scheduleSuggestLabel.snp.bottom).offset(Appearance.size.small)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.bottom.equalToSuperview().offset(-Appearance.size.small)
        }
    }
}
