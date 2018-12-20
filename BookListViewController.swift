//
//  ViewController.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/29.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SnapKit
import os.log

class BookListViewController: UIViewController {

    var bannerView: GADBannerView = {
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        return bannerView
    }()

    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "読書リスト"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.leftBarBtnClicked))
        //広告バナー
        self.addBannerViewToView()
        //TableView
        self.addTableViewToView()

        //データの呼び出し
        if let savedBooks = loadBooks() {
            self.books += savedBooks
        }


    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //よくわからんがviewWillAppearだとリロードが間に合わなかった
        self.tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    override func viewWillAppear(_ animated: Bool) {

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    func addBannerViewToView() {
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func addTableViewToView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(BookCell.self, forCellReuseIdentifier: NSStringFromClass(BookCell.self))
        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.bannerView.snp.top)
        }
    }

    //左側のボタンが押されたら呼ばれる
    @objc func leftBarBtnClicked(){
        let second = BookEditViewController()
        //遷移先のMealViewControllerに遷移元のself(MealTableViewController)を渡しておく
        second.originViewController = self
        //遷移する前にナビゲーションコントローラーのインスタンスに遷移先のViewContorollerを入れる
        let navVC = UINavigationController(rootViewController:second)
        //ナビゲーションコントローラーの渡してモーダル遷移を行う
        self.present(navVC, animated: true, completion: nil)
    }

    //MealViewControllerから戻ってきた時mealsにデータを入れる
    func unwindToMealList(sourceViewController: BookEditViewController) {

        if let book = sourceViewController.book {
            // booksの配列に新しいデータを入れる
            let newIndexPath = IndexPath(row: books.count, section: 0)
            books.append(book)
            saveBooks()
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    //すでに入っているデータを修正する
    func fixToMealList(sourceViewController: BookEditViewController, indexPath: IndexPath) {
        if let book = sourceViewController.book {
            // mealsの配列に新しいデータを入れる
            self.books[indexPath.row] = book
            saveBooks()
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    //データの永続化 meals を保存するタイミングになったらこのメソッドを呼び出す
    //このメソッドには保存できる形式にした Meal オブジェクトを適切な場所に保存する処理をかく
    private func saveBooks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(books, toFile: Book.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("保存が成功しました", log: OSLog.default, type: .debug)
        } else {
            os_log("保存が失敗しました", log:OSLog.default, type: .error)
        }
    }

    private func loadBooks() -> [Book]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Book.ArchiveURL.path) as? [Book]
    }


}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        self.tableView.deselectRow(at: indexPath, animated: true)
        let bookViewController = BookEditViewController()
        bookViewController.originViewController = self
        let selectedBook = books[indexPath.row]
        bookViewController.book = selectedBook
        bookViewController.selectedIndexPath = indexPath
        self.navigationController?.pushViewController(bookViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension BookListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BookCell.self), for: indexPath) as? BookCell else {
            return UITableViewCell(frame: .zero)
        }
        cell.accessoryType = .disclosureIndicator

        let book = books[indexPath.row]
        cell.bookNameLabel.text = book.bookName
        cell.deadlineLabel.text = book.targetDate
        cell.slider.fraction = CGFloat(book.currentPage) / CGFloat(book.totalPageNumber)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Appearance.font.sliderLabel(),
            .foregroundColor: Appearance.color.sliderLabel
        ]
        cell.slider.setMaximumLabelAttributedText(NSAttributedString(string: String(book.totalPageNumber), attributes: attributes))

        //セルの高さ自動計算に必要
        cell.layoutIfNeeded()

        return cell
    }

}
