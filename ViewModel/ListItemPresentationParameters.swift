//
//  ItemViewModel.swift
//  ViewModel
//
//  Created by DF on 8/27/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import Foundation
import Model

public protocol ListItemPresentationParameters {
    static var cellHeight: CGFloat { get }

    var backgroundColor: UIColor? { get }
    var selectedBackgroundColor: UIColor? { get }
    var textColor: UIColor? { get }

    var nameFont: UIFont? { get }
}

public extension ListItemPresentationParameters {
    static var cellHeight: CGFloat {
        return CGFloat(48.0)
    }

    var backgroundColor: UIColor? {
        if #available(iOS 11, *) {
            return UIColor(named: "ItemCellBackgroundColor")
        }
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    var selectedBackgroundColor: UIColor? {
        if #available(iOS 11, *) {
            return UIColor(named: "CellBackgroundSelectedColor")
        }
        return #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
    }

    var textColor: UIColor? {
        if #available(iOS 11, *) {
            return UIColor(named: "TextColor")
        }
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }

    var nameFont: UIFont? {
        return UIFont(name: "Roboto-Light", size: 16.0)
    }
}
