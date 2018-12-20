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

    let totalPageLabel: UILabel = {
        let label = UILabel()
        label.text = "総ページ数"
        label.font = Appearance.font.label(15, weight: .semibold)
        label.textColor = Appearance.color.font
        return label
    }()

    //数値の範囲（1...10という記法）を配列にする
    var pageNumberArray:[Int] = ([Int])(0...1000)

    var pageNumberDatePickerView: UIPickerView = {
        var pickerView = UIPickerView()
        return pickerView
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

    let labelStringAttributes: [NSAttributedString.Key : Any] = [
        .foregroundColor : Appearance.color.sliderLabel,
        .font : Appearance.font.sliderLabel(15)
    ]
    let textStringAttributes: [NSAttributedString.Key : Any] = [
        .foregroundColor : Appearance.color.slider,
        .font : Appearance.font.sliderLabel(15)
    ]


    let slider: Slider = {
        let slider = Slider()
        slider.fraction = 0
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = Appearance.color.slider
        slider.valueViewColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.didBeginTracking = { slider in

            print("///////slider",slider)
        }
        slider.didEndTracking = { slider in

            print("///////slider",slider)
        }
        return slider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()

        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー設定
        self.deadlineTextFiled.inputAccessoryView = toolbar
        self.deadlineTextFiled.inputView = self.deadlineDatePicker

        // スライダー設定
        self.slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: self.textStringAttributes)
        }
        self.slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: self.labelStringAttributes))
        self.slider.setMaximumLabelAttributedText(NSAttributedString(string: "500", attributes: self.labelStringAttributes))
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
        self.addSubview(self.totalPageLabel)
        self.addSubview(self.pageNumberDatePickerView)
        self.addSubview(self.pageDescriptionLabel)
        self.addSubview(self.slider)

        self.layoutBookNameLabel()
        self.layoutBookNameTextFiled()
        self.layoutDeadlineLabel()
        self.layoutDeadlineTextFiled()
        self.layoutTotalPageLabel()
        self.layoutPageNumberDatePickerView()
        self.layoutPageDescriptionLabel()
        self.layoutSlider()
    }

    //本のタイトルの説明ラベル
    private func layoutBookNameLabel() {
        self.bookNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(Appearance.size.extraLarge)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.bookNameTextFiled.snp.top).offset(-Appearance.size.small)
        }
    }

    //本のタイトル記入テキストフィールド
    private func layoutBookNameTextFiled() {
        self.bookNameTextFiled.snp.makeConstraints{ make in
            make.top.equalTo(self.bookNameLabel.snp.bottom).offset(Appearance.size.small)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.bottom.equalTo(self.deadlineLabel.snp.top).offset(-Appearance.size.extraLarge)
        }
    }

    //読了達成目標日の説明ラベル
    private func layoutDeadlineLabel() {
        self.deadlineLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.bookNameTextFiled.snp.bottom).offset(Appearance.size.extraLarge)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.bottom.equalTo(self.deadlineTextFiled.snp.top).offset(-Appearance.size.small)
        }
    }

    //読了達成目標日記入テキストフィールド
    private func layoutDeadlineTextFiled() {
        self.deadlineTextFiled.snp.makeConstraints{ make in
            make.top.equalTo(self.deadlineLabel.snp.bottom).offset(Appearance.size.small)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.bottom.equalTo(self.totalPageLabel.snp.top).offset(-Appearance.size.extraLarge)
        }
    }

    //総ページ数説明ラベル
    private func layoutTotalPageLabel() {
        self.totalPageLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.deadlineTextFiled.snp.bottom).offset(Appearance.size.small)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.pageNumberDatePickerView.snp.top).offset(-Appearance.size.small)
        }
    }

    //総ページ数記入テキストフィールド
    private func layoutPageNumberDatePickerView() {
        self.pageNumberDatePickerView.snp.makeConstraints{ make in
            make.top.equalTo(self.totalPageLabel.snp.bottom).offset(Appearance.size.small)
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.extraLarge)
            make.bottom.equalTo(self.pageDescriptionLabel.snp.top).offset(-Appearance.size.extraLarge)
        }
    }

    //読了ページ数説明ラベル
    private func layoutPageDescriptionLabel() {
        self.pageDescriptionLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.pageNumberDatePickerView.snp.bottom).offset(Appearance.size.extraLarge)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
        }
    }

    //スライダー
    private func layoutSlider() {
        self.slider.snp.makeConstraints{ make in
            make.top.equalTo(self.pageDescriptionLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(Appearance.size.small)
            make.right.equalToSuperview().offset(-Appearance.size.small)
            make.height.equalTo(40)
        }
    }
}

//class BiblioSlider: Slider {
//
//    override var contentView
//}
