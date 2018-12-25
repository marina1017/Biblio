//
//  UIView+extension.swift
//  Biblio
//
//  Created by 中川万莉奈 on 2018/12/26.
//  Copyright © 2018年 nakagawa. All rights reserved.
//
import UIKit

extension UIView {
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}
