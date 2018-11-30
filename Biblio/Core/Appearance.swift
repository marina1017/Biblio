//
//  Appearance.swift
//  Biblio
//
//  Created by nakagawa on 2018/11/30.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit

final class Appearance {

    struct Font {
        func `default`(_ size: CGFloat = UIFont.systemFontSize, weight: UIFont.Weight = .regular) -> UIFont {
            if weight == .bold {
                return UIFont.boldSystemFont(ofSize: size)
            }
            return UIFont.systemFont(ofSize:size, weight: weight)
        }

        func label(_ size: CGFloat = UIFont.labelFontSize, weight: UIFont.Weight = .regular) -> UIFont {
            return Appearance.font.default(size, weight: weight)
        }

        func button(_ size: CGFloat = UIFont.buttonFontSize, weight: UIFont.Weight = .regular) -> UIFont {
            return Appearance.font.default(size, weight: weight)
        }
    }

    struct Margin {
        var small: CGFloat {
            return 5
        }

        var `default`: CGFloat {
            return 10
        }

        var large: CGFloat {
            return 15
        }
    }

    struct Size {
        var extraSmall: CGFloat {
            return 5
        }

        var small: CGFloat {
            return 10
        }

        var medium: CGFloat {
            return 15
        }

        var `default`: CGFloat {
            return 20
        }

        var large: CGFloat {
            return 25
        }

        var extraLarge: CGFloat {
            return 30
        }

    }

    struct Color {
        let background = UIColor.format(hex: 0xf0f0f0)

        let font = UIColor.format(hex: 0x303030)
    }

    static let font = Appearance.Font()
    static let margin = Appearance.Margin()
    static let size = Appearance.Size()
    static let color = Appearance.Color()


}

extension UIColor {

    static func format(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00ff00) >>  8) / 255.0
        let b = CGFloat((hex & 0x0000ff) >>  0) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
