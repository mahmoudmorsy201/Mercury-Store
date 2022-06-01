//
//  UILabel+AppStyle.swift
//  Mercury-Store
//
//  Created by mac hub on 01/06/2022.
//

import UIKit

enum LabelStyle {
    case title
    case body
    case headLine
}

extension UILabel {
    func style(_ labelStyle: LabelStyle) {
        switch labelStyle {
        case .title:
            font = .heavyFont(size: .regular)
            textColor = .label
        case .body:
            font = .regularFont(size: .small)
            textColor = .secondaryLabel
        case .headLine:
            font = .heavyFont(size: .headLine)
            textColor = .label
        }
    }
}

