//
//  GroupSectionView.swift
//  View
//
//  Created by DF on 8/28/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import UIKit
import ViewModel

class ListItemView: UIView, UIGestureRecognizerDelegate {
    let label: UILabel
    var parameters: ListItemPresentationParameters?
    public var name: String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    private var longPressRecognizer: UILongPressGestureRecognizer?
    private var tapRecognizer: UILongPressGestureRecognizer?
    public var onLongPressDetected: (() -> Void)?
    public var onTapDetected: (() -> Void)?
    override public init(frame: CGRect) {
        self.label = UILabel(frame: .zero)
        self.label.numberOfLines = 1
        self.label.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        self.addSubview(self.label)
        self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 36.0).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.label.setContentCompressionResistancePriority(.required, for: .vertical)
        self.label.setContentHuggingPriority(.required, for: .vertical)
        self.longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                                action: #selector(longPressDetected(sender:)))
        self.longPressRecognizer?.delegate = self
        self.addGestureRecognizer(self.longPressRecognizer!)
        self.tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tapDetected(sender:)))
        self.tapRecognizer?.minimumPressDuration = 0.1
        self.tapRecognizer?.delegate = self
        self.addGestureRecognizer(self.tapRecognizer!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer is UIPanGestureRecognizer || otherGestureRecognizer == self.longPressRecognizer {
            return false
        }
        return true
    }

    @objc private func longPressDetected(sender: Any) {
        if let sender = sender as? UILongPressGestureRecognizer,
            sender.state == .began,
            let onLongPressDetected = self.onLongPressDetected {
            onLongPressDetected()
            self.highlight(false)
        }
    }

    @objc private func tapDetected(sender: Any) {
        if let sender = sender as? UILongPressGestureRecognizer {
            switch sender.state {
            case .ended:
                if let onTapDetected = self.onTapDetected,
                    self.longPressRecognizer?.state != UIGestureRecognizer.State.recognized {
                    onTapDetected()
                }
                self.highlight(false)
            case .began:
                self.highlight(true)
            default:
                self.highlight(false)
            }
        }
    }

    public func updateAppearance(_ parameters: ListItemPresentationParameters) {
        self.parameters = parameters
        self.label.textColor = parameters.textColor
        self.label.font = parameters.nameFont
        self.backgroundColor = parameters.backgroundColor
    }

    public func highlight(_ highlight: Bool) {
        if highlight {
            self.backgroundColor = self.parameters?.selectedBackgroundColor
        } else {
            self.backgroundColor = self.parameters?.backgroundColor
        }
    }
}

class GroupSectionView: UITableViewHeaderFooterView {
    private let listItemView: ListItemView
    override init(reuseIdentifier: String?) {
        self.listItemView = ListItemView()
        self.listItemView.translatesAutoresizingMaskIntoConstraints = false
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(self.listItemView)
        self.listItemView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.listItemView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.listItemView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.listItemView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with viewModel: GroupViewModel) {
        self.listItemView.updateAppearance(viewModel)
        self.listItemView.name = viewModel.name
    }

    var onTapDetected: (() -> Void)? {
        get {
            return nil
        }
        set {
            self.listItemView.onTapDetected = newValue
        }
    }

    var onLongPressDetected: (() -> Void)? {
        get {
            return nil
        }
        set {
            self.listItemView.onLongPressDetected = newValue
        }
    }
}
