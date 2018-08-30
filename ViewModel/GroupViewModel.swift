//
//  ControllerViewModel.swift
//  GroupedList
//
//  Created by DF on 8/27/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import Foundation
import Model

public class GroupViewModel: ListItemPresentationParameters {
    public var name: String {
        return self.group.name ?? ""
    }
    
    public var isHidden: Bool {
        get {
            return self.items.isEmpty
        }
    }
    
    public var isIdEven: Bool {
        return self.group.id%2 == 0
    }
    
    public var backgroundColor: UIColor? {
        return UIColor(named: "GroupCellBackgroundColor")
    }
    
    public let items:[ItemViewModel]
    
    public var expanded = false
    
    public func toggle(inSection section:Int) -> (insert:[IndexPath]?, delete:[IndexPath]?) {
        var itemsToToggle = [IndexPath]()
        for index in 0..<self.items.count {
            let indexPath = IndexPath(row: index, section: section)
            itemsToToggle.append(indexPath)
        }
        if self.expanded {
            self.expanded = false
            return (nil, itemsToToggle)
        }
        else {
            self.expanded = true
            return (itemsToToggle, nil)
        }
    }
    
    public var numberOfItems: Int {
        return self.expanded ? self.items.count : 0
    }
    
    private let group:Group
    
    init(group:Group) {
        self.group = group
        self.items = group.items.map({ (item:Item) -> ItemViewModel in
            let itemViewModel = ItemViewModel(item:item)
            return itemViewModel
        })
    }
}


public struct ItemViewModel: ListItemPresentationParameters {
    public var name:String? {
        return item.name
    }
    
    private let item:Item
    public init(item:Item) {
        self.item = item
    }
}
