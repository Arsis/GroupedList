//
//  Model.swift
//  Model
//
//  Created by DF on 8/27/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import Foundation

public struct Item {
    public let name: String
}

public struct Group {
    public let name: String?
    public let items: [Item]
    public let groupId: Int
    public init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String
        self.groupId = dictionary["id"] as? Int ?? 0
        var items = [Item]()
        if let itemsArray = dictionary["items"] as? [Any] {
            for item in itemsArray {
                if let item = item as? [String: Any], let name = item["name"] as? String {
                    let item = Item(name: name)
                    items.append(item)
                }
            }
        }
        self.items = items
    }
}

public enum ResourceDetails {
    public static let filename = "data"
    public static let fileType = "json"
}

public enum GroupedListError: Error {
    case dataFileNotFound
    case dataFileIsEmpty
    case invalidDataFormat
}

public protocol DataProvider {
    func fetchData(url: URL, completion: ([String: Any]?, Error?) -> Void)
}

public class BundleDataProvider: DataProvider {
    public init() { }
    public func fetchData(url: URL, completion: ([String: Any]?, Error?) -> Void) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: url.path) {
            if let data = fileManager.contents(atPath: url.path), data.isEmpty == false {
                let dictionary = try? JSONSerialization.jsonObject(with: data, options: .init(rawValue:0))
                if let dictionary = dictionary as? [String: Any] {
                    completion(dictionary, nil)
                } else {
                    completion(nil, GroupedListError.invalidDataFormat)
                }
            } else {
                completion(nil, GroupedListError.dataFileIsEmpty)
            }
        } else {
            completion(nil, GroupedListError.dataFileNotFound)
        }
    }
}
