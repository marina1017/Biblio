//
//  BookEditView.swift
//  Biblio
//
//  Created by nakagawa on 2018/12/16.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import fluid_slider

class BookEditView: UIView {
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = "本のタイトル"
        label.font = Appearance.font.label(15, weight: .semibold)
        label.textColor = Appearance.color.font
        return label
    }()

    var bookNameTextFiled: UITextField = {
        var textFiled = UITextField()
        textFiled.placeholder = "本のタイトルを入力"
        textFiled.font = Appearance.font.label(15, weight: .semibold)
        textFiled.borderStyle = .roundedRect
        textFiled.enablesReturnKeyAutomatically = true
        textFiled.keyboardType = UIKeyboardType.emailAddress
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.keyboardAppearance = UIKeyboardAppearance.alert
        textFiled.textContentType = UITextContentType.emailAddress
        textFiled.translatesAutoresizingMaskIntoConstraints = false

        return textFiled
    }()

    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "読了達成目標日"
        label.font = Appearance.font.label(15, weight: .semibold)
        label.textColor = Appearance.color.font
        return label
    }()

    let deadlineTextFiled: UITextField = {
        var textFiled = UITextField()
        textFiled.placeholder = "読了達成目標日を入力"
        textFiled.font = Appearance.font.label(15, weight: .semibold)
        textFiled.borderStyle = .roundedRect
        textFiled.enablesReturnKeyAutomatically = true
        textFiled.keyboardType = UIKeyboardType.emailAddress
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.keyboardAppearance = UIKeyboardAppearance.alert
        textFiled.textContentType = UITextContentType.emailAddress
        textFiled.translatesAutoresizingMaskIntoConstraints = false

        return textFiled
    }()

    let pageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "読了ページ数"
        label.font = Appearance.font.label(15, weight: .semibold)
        label.textColor = Appearance.color.font
        return label
    }()

    var deadlineDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current


        return datePicker
    }()

    let slider: Slider = {
        let slider = Slider()
        let textStringAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 1),
            .font : UIFont.systemFont(ofSize: 15.0)
        ]
        let labelStringAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.boldSystemFont(ofSize: 15.0)
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
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 1)
        slider.valueViewColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        self.deadlineTextFiled.inputView = self.deadlineDatePicker
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー設定
        deadlineTextFiled.inputAccessoryView = toolbar
    }

    //決定ボタン押下
    @objc func done() {
        deadlineTextFiled.endEditing(true)

        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        deadlineTextFiled.text = "\(formatter.string(from: Date()))"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.addSubview(self.bookNameLabel)
        self.addSubview(self.bookNameTextFiled)
        self.addSubview(self.deadlineLabel)
        self.addSubview(self.deadlineTextFiled)
        self.addSubview(self.pageDescriptionLabel)
        self.addSubview(self.slider)

        self.layoutBookNameLabel()
        self.layoutBookNameTextFiled()
        self.layoutDeadlineLabel()
        self.layoutDeadlineTextFiled()
        self.layoutPageDescriptionLabel()
        self.layoutSlider()
    }

    private func layoutBookNameLabel() {
        self.bookNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(Appearance.size.extraLarge)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.bookNameTextFiled.snp.top).offset(-Appearance.size.small)
        }
    }

    private func layoutBookNameTextFiled() {
        self.bookNameTextFiled.snp.makeConstraints{ make in
            make.top.equalTo(self.bookNameLabel.snp.bottom).offset(Appearance.size.small)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.bottom.equalTo(self.deadlineLabel.snp.top).offset(-Appearance.size.extraLarge)
        }
    }

    private func layoutDeadlineLabel() {
        self.deadlineLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.bookNameTextFiled.snp.bottom).offset(Appearance.size.extraLarge)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.bottom.equalTo(self.deadlineTextFiled.snp.top).offset(-Appearance.size.small)
        }
    }

    private func layoutDeadlineTextFiled() {
        self.deadlineTextFiled.snp.makeConstraints{ make in
            make.top.equalTo(self.deadlineLabel.snp.bottom).offset(Appearance.size.small)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.pageDescriptionLabel.snp.top).offset(-Appearance.size.extraLarge)
        }
    }

    private func layoutPageDescriptionLabel() {
        self.pageDescriptionLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.deadlineTextFiled.snp.bottom).offset(Appearance.size.extraLarge)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
        }
    }

    private func layoutSlider() {
        self.slider.snp.makeConstraints{ make in
            make.top.equalTo(self.pageDescriptionLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.height.equalTo(40)
        }
    }
}
