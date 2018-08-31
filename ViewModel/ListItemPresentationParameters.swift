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
        return nil
    }

    var selectedBackgroundColor: UIColor? {
        if #available(iOS 11, *) {
            return UIColor(named: "CellBackgroundSelectedColor")
        }
        return nil
    }

    var textColor: UIColor? {
        if #available(iOS 11, *) {
            return UIColor(named: "TextColor")
        }
        return nil
    }

    var nameFont: UIFont? {
        return UIFont(name: "Roboto-Light", size: 16.0)
    }
}
