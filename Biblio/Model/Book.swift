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
    var deadline: String = ""
    var deadlineDate: Date = Date()
    var totalPageNumber: Int = 0
    var sliderFlaction: CGFloat = 0
    var currentPage: Int = 0

    //MARK: Properties
    struct PropertyKey {
        static let bookName = "name"
        static let deadline = "deadline"
        static let deadlineDate = "deadlineDate"
        static let totalPageNumber = "totalPageNumber"
        static let sliderFlaction = "sliderFlaction"
        static let currentPage = "currentPage"
    }

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("book")

    //MARK: 初期化
    init?(bookName: String, deadline: String, deadlineDate:Date, totalPageNumber: Int, sliderFlaction: CGFloat ,currentPage: Int) {
        //nameに何も入ってない時
        guard !bookName.isEmpty else {
            return nil
        }

        // プロパティの初期化
        self.bookName = bookName
        self.deadline = deadline
        self.deadlineDate = deadlineDate
        self.totalPageNumber = totalPageNumber
        self.sliderFlaction = sliderFlaction
        self.currentPage = currentPage
    }

    func encode(with aCoder: NSCoder) {
        let sliderFlaction = Float(self.sliderFlaction)
        aCoder.encode(self.bookName, forKey: PropertyKey.bookName)
        aCoder.encode(self.deadline, forKey: PropertyKey.deadline)
        aCoder.encode(self.deadlineDate, forKey: PropertyKey.deadlineDate)
        aCoder.encode(self.totalPageNumber, forKey: PropertyKey.totalPageNumber)
        aCoder.encode(sliderFlaction, forKey: PropertyKey.sliderFlaction)
        aCoder.encode(self.currentPage, forKey: PropertyKey.currentPage)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let bookName = aDecoder.decodeObject(forKey: PropertyKey.bookName) as? String else {
            //os_log("Unable to decode the name for a Meal Object.", log: OSLog.default, type: .debug)
            return nil
        }
        //写真はオプションのプロパティなので条件付きキャストを作る
        guard let deadline = aDecoder.decodeObject(forKey: PropertyKey.deadline) as? String else {
            return nil
        }

        guard let deadlineDate = aDecoder.decodeObject(forKey: PropertyKey.deadlineDate) as? Date else {
            return nil
        }

        let totalPageNumber = aDecoder.decodeInteger(forKey: PropertyKey.totalPageNumber)

        let sliderFlaction = CGFloat(aDecoder.decodeDouble(forKey: PropertyKey.sliderFlaction))

        let currentPage = aDecoder.decodeInteger(forKey: PropertyKey.currentPage)


        //指定された初期化子を呼び出さなければならない
        self.init(bookName: bookName, deadline: deadline, deadlineDate: deadlineDate, totalPageNumber: totalPageNumber, sliderFlaction: sliderFlaction, currentPage: currentPage)
    }


}
