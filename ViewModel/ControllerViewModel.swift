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

    private var groups: [GroupViewModel]? {
        didSet {
            visibleGroups = groups?.filter({ !$0.isHidden })
        }
    }

    public var visibleGroups: [GroupViewModel]?

    public func getGroups(completion: (Bool, Error?) -> Void) {
        if let resoucePath = Bundle.main.path(forResource: ResourceDetails.filename, ofType: ResourceDetails.fileType) {
            let url = URL(fileURLWithPath: resoucePath)
            self.dataProvider.fetchData(url: url) { (data: Data?, error: Error?) in
                if let data = data {
                    do {
                        let parsedData = try JSONDecoder().decode([String: [Group]].self, from: data)
                        self.groups = parsedData.map({ (_: String, value: [Group]) -> [GroupViewModel] in
                            let array = value.map({ (group: Group) -> GroupViewModel in
                                GroupViewModel(group: group)
                            })
                            return array
                        }).reduce([], +)
                        completion(true, nil)
                    } catch {
                        print(error)
                        completion(false, error)
                    }
                } else if let error = error {
                    completion(false, error)
                }
            }
        }
    }

    public var numberOfSections: Int {
        return self.visibleGroups?.count ?? 0
    }

    public func numberOfRowsInSection(_ section: Int) -> Int {
        if let count = visibleGroups?.count, section >= count {
            return 0
        }
        if let group = visibleGroups?[section] {
            return group.numberOfItems
        }
        return 0
    }

    public func itemAtIndexPath(_ indexPath: IndexPath) -> ItemViewModel? {
        if let groupsCount = visibleGroups?.count, indexPath.section < groupsCount,
            let group = visibleGroups?[indexPath.section] {
            if indexPath.row < group.items.count {
                return group.items[indexPath.row]
            }
        }
        return nil
    }
}
