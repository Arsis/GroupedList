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
        return UIColor(named: "ItemCellBackgroundColor")
    }
    
    var selectedBackgroundColor: UIColor? {
        return UIColor(named: "CellBackgroundSelectedColor")
    }
    
    var textColor: UIColor? {
        return UIColor(named: "TextColor")
    }
    
    var nameFont: UIFont? {
        return UIFont(name: "Roboto-Light", size: 16.0)
    }
}
