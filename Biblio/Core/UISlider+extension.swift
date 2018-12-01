//
//  UISlider+extension.swift
//  Biblio
//
//  Created by nakagawa on 2018/12/01.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit

extension UISlider {

    var trackBounds: CGRect {
        return trackRect(forBounds: bounds)
    }

    var trackFrame: CGRect {
        guard let superView = superview else { return CGRect.zero }
        return self.convert(trackBounds, to: superView)
    }

    var thumbBounds: CGRect {
        return thumbRect(forBounds: frame, trackRect: trackBounds, value: value)
    }

    var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackFrame, value: value)
    }
}
