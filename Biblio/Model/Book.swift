//
//  Book.swift
//  Biblio
//
//  Created by nakagawa on 2018/12/16.
//  Copyright © 2018年 nakagawa. All rights reserved.
//
import UIKit

class Book: NSObject, NSCoding {

    //MARK: Properties
    var bookName: String = ""
    var targetDate: String = ""
    var totalPageNumber: Int = 0
    var currentPage: Int = 0

    //MARK: Properties
    struct PropertyKey {
        static let bookName = "name"
        static let targetDate = "targetDate"
        static let totalPageNumber = "totalPageNumber"
        static let currentPage = "currentPage"
    }

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("book")

    //MARK: 初期化
    init?(bookName: String, targetDate: String, totalPageNumber: Int, currentPage: Int) {
        //nameに何も入ってない時
        guard !bookName.isEmpty else {
            return nil
        }

        // プロパティの初期化
        self.bookName = bookName
        self.targetDate = targetDate
        self.totalPageNumber = totalPageNumber
        self.currentPage = currentPage
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.bookName, forKey: PropertyKey.bookName)
        aCoder.encode(self.targetDate, forKey: PropertyKey.targetDate)
        aCoder.encode(self.totalPageNumber, forKey: PropertyKey.totalPageNumber)
        aCoder.encode(self.currentPage, forKey: PropertyKey.currentPage)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let bookName = aDecoder.decodeObject(forKey: PropertyKey.bookName) as? String else {
            //os_log("Unable to decode the name for a Meal Object.", log: OSLog.default, type: .debug)
            return nil
        }
        //写真はオプションのプロパティなので条件付きキャストを作る
        guard let targetDate = aDecoder.decodeObject(forKey: PropertyKey.targetDate) as? String else {
            return nil
        }

        let totalPageNumber = aDecoder.decodeInteger(forKey: PropertyKey.totalPageNumber)

        let currentPage = aDecoder.decodeInteger(forKey: PropertyKey.currentPage)

        //指定された初期化子を呼び出さなければならない
        self.init(bookName: bookName, targetDate: targetDate, totalPageNumber: totalPageNumber, currentPage: currentPage)
    }


}
