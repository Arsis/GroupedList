//
//  ControllerViewModel.swift
//  ViewModel
//
//  Created by DF on 8/27/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import Foundation
import Model

public class ControllerViewModel {
    let dataProvider: DataProvider
    
    public init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    private var groups:[GroupViewModel]? {
        didSet {
            visibleGroups = groups?.filter({ (groupViewModel:GroupViewModel) -> Bool in
                return groupViewModel.isHidden == false
            })
        }
    }
    
    public var visibleGroups:[GroupViewModel]?
    
    public func getGroups(completion:(Bool, Error?)->()) {
        if let resoucePath = Bundle.main.path(forResource: ResourceDetails.filename, ofType: ResourceDetails.fileType) {
            let url = URL(fileURLWithPath: resoucePath)
            self.dataProvider.fetchData(url:url) { (dictionary:Dictionary<String,Any>?, error:Error?) in
                if let dictionary = dictionary, let groupsArray = dictionary["Data"] as? Array<Dictionary<String, Any>> {
                    self.groups = groupsArray.map({ (groupInfo:Dictionary<String, Any>) -> GroupViewModel in
                        let group = Group(dictionary:groupInfo)
                        return GroupViewModel(group: group)
                    })
                    completion(true, nil)
                }
                else if let error = error {
                    completion(false,error)
                }
            }
        }
    }
    
    public var numberOfSections: Int {
        return self.visibleGroups?.count ?? 0
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        if let count = visibleGroups?.count, section >= count    {
            return 0
        }
        if let group = visibleGroups?[section] {
            return group.numberOfItems
        }
        return 0
    }        
    
    public func itemAtIndexPath(_ indexPath: IndexPath) -> ItemViewModel? {
        if let groupsCount = visibleGroups?.count, indexPath.section < groupsCount {
            if let group = visibleGroups?[indexPath.section] {
                if indexPath.row < group.items.count {
                    return group.items[indexPath.row]
                }
            }
        }
        return nil
    }
}
