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

    var cancelButton: UIBarButtonItem!
    var saveButton: UIBarButtonItem!
    var originViewController = BookListViewController()
    //選択されたセル番号を保存する
    var selectedIndexPath: IndexPath!

    var book: Book?
    var selectedValue: Int = 500
    
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

        //MARK: ナビゲーションバーの設定
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(BookEditViewController.tappedRightBarButton))
        self.navigationItem.rightBarButtonItem = self.saveButton
        if self.presentingViewController != nil {
            self.navigationItem.title = "新規追加"
            cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(BookEditViewController.tappedLeftBarButton))
            self.navigationItem.leftBarButtonItem = self.cancelButton
        }

        //bookにデータが入っている場合
        if let book = self.book {
            self.navigationItem.title = book.bookName
            self.bookEditView.bookNameTextFiled.text = book.bookName
            self.bookEditView.deadlineTextFiled.text = book.targetDate
            self.bookEditView.pageNumberDatePickerView.selectRow(book.totalPageNumber, inComponent: 0, animated: true)
            self.bookEditView.slider.attributedTextForFraction = { fraction in
                let formatter = NumberFormatter()
                formatter.maximumIntegerDigits = 3
                formatter.maximumFractionDigits = 0
                let string = formatter.string(from: (fraction * CGFloat(book.currentPage)) as NSNumber) ?? ""
                return NSAttributedString(string: string, attributes: self.bookEditView.textStringAttributes)
            }

        }



    }
    //MARK: キーボードが出ている状態で、キーボード以外をタップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        if(self.bookEditView.bookNameTextFiled.isFirstResponder){
            self.bookEditView.bookNameTextFiled.resignFirstResponder()
        }
    }

    //MARK: saveボタンをタップしたときのアクション
    @objc func tappedRightBarButton() {
        //キーボードをしまう
        self.bookEditView.bookNameTextFiled.resignFirstResponder()

        //変更されたデータを入れる
        var bookName: String = self.bookEditView.bookNameTextFiled.text ?? ""
        var targetDate: String = self.bookEditView.deadlineTextFiled.text ?? ""
        var totalPageNumber: Int = self.selectedValue
        var currentPage: Int = 50

        book = Book(bookName: bookName, targetDate: targetDate, totalPageNumber: totalPageNumber, currentPage: currentPage)

        //現在モーダル遷移かプッシュ遷移どちらで表示されているのか判定する
        let isPresentingIndAddMealMode = presentingViewController is UINavigationController
        //モーダルの時に実行する関数
        if isPresentingIndAddMealMode {
            self.originViewController.unwindToMealList(sourceViewController: self)
            self.dismiss(animated: true, completion:nil)
        }
            //プッシュの時に実行する関数
        else if let owingNavigationController = navigationController {
            self.originViewController.fixToMealList(sourceViewController: self, indexPath: self.selectedIndexPath)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }

    }

    //MARK: キャンセルボタンをタップしたときのアクション
    @objc func tappedLeftBarButton() {
        self.dismiss(animated: true, completion: nil)

    }

    //MARK: エディットボタンをタップしたときのアクション
    @objc func tappedEditButton() {
//        //キーボードをしまう
//        self.myStackView.textFiled.resignFirstResponder()
//
//        let name = self.myStackView.textFiled.text ?? ""
//        let photo = self.myStackView.imageView.image
//        let rating = self.myStackView.ratingControllView.rating
//
//        meal = Meal(name: name, photo: photo, rating: rating)
//
//        self.originViewController.fixToMealList(sourceViewController: self, indexPath: self.selectedIndexPath)
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
        self.selectedValue = row

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
