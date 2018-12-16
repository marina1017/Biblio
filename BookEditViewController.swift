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
        self.bookEditView.bookNameTextFiled.delegate = self
        self.bookEditView.pageNumberDatePickerView.dataSource = self
        self.bookEditView.pageNumberDatePickerView.delegate = self
        self.bookEditView.pageNumberDatePickerView.selectRow(500, inComponent: 0, animated: true)

    }
    //MARK: キーボードが出ている状態で、キーボード以外をタップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        if(self.bookEditView.bookNameTextFiled.isFirstResponder){
            self.bookEditView.bookNameTextFiled.resignFirstResponder()
        }

    }


}

extension BookEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{

        //label.text = textField.text

        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}

extension BookEditViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bookEditView.pageNumberArray.count
    }


}

extension BookEditViewController: UIPickerViewDelegate {
    //PickerViewのコンポーネントに表示するデータを決めるメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.bookEditView.pageNumberArray[row]) + "ページ"
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        // 表示するラベルを生成する
        let label = UILabel()
        label.textAlignment = .center
        label.text = String(self.bookEditView.pageNumberArray[row]) + "ページ"
        label.font = Appearance.font.label(20, weight: .semibold)
        label.textColor = Appearance.color.font
        return label
    }

    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.bookEditView.slider.setMaximumLabelAttributedText(NSAttributedString(string: String(row), attributes: self.bookEditView.labelStringAttributes))
        self.bookEditView.slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * CGFloat(row)) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: self.bookEditView.textStringAttributes)
        }
    }

}
