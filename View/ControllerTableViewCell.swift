//
//  ControllerTableViewCell.swift
//  View
//
//  Created by DF on 8/27/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import UIKit
import ViewModel

class ControllerTableViewCell: UITableViewCell {
    private let listItemView: ListItemView

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var onLongPressDetected: (() -> Void)? {
        get {
            return nil
        }
        set {
            self.listItemView.onLongPressDetected = newValue
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.listItemView = ListItemView()
        self.listItemView.translatesAutoresizingMaskIntoConstraints = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.listItemView)
        self.listItemView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.listItemView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.listItemView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.listItemView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
        super.init(coder: aDecoder)
    }

    func update(with viewModel: ItemViewModel) {
        self.listItemView.updateAppearance(viewModel)
        self.listItemView.name = viewModel.name
    }
}
