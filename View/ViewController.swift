//
//  ViewController.swift
//  GroupedList
//
//  Created by DF on 8/27/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import UIKit
import ViewModel

public class ViewController: UIViewController {
    let tableView: UITableView
    let viewModel: ControllerViewModel?

    public required init(viewModel: ControllerViewModel, nibName nibNameOrNil: String?,
                         bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = nil
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = nil
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        guard let viewModel = self.viewModel else {
            return
        }
        viewModel.getGroups { [weak self] (success: Bool, error: Error?) in
            if success == false, let error = error {
                self?.displayError(error)
            } else {
                self?.tableView.reloadData()
            }
        }
    }

    override public func loadView() {
        self.view = UIView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = ItemViewModel.cellHeight
        self.tableView.sectionHeaderHeight = GroupViewModel.cellHeight
        self.tableView.register(ControllerTableViewCell.self, forCellReuseIdentifier: "item.cell.id")
        self.tableView.register(GroupSectionView.self, forHeaderFooterViewReuseIdentifier: "item.header.id")
        self.view.addSubview(self.tableView)
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }

    fileprivate func itemLongPressDetected(indexPath: IndexPath) {
        if let groupViewModel = self.viewModel?.visibleGroups?[indexPath.section],
            let itemViewModel = self.viewModel?.itemAtIndexPath(indexPath) {
            let alertController = UIAlertController.init(title: groupViewModel.name,
                                                         message: itemViewModel.name, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    fileprivate func groupLongPressDetected(viewModel: GroupViewModel) {
        self.tableView.rotate(duration: 1, clockwise: viewModel.isIdEven)
    }

    func displayError(_ error: Error) {
        //TODO: display error
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK:- data source
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.numberOfSections ?? 0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRowsInSection(section) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "item.cell.id")!
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "item.header.id") as? GroupSectionView {
            guard let groupViewModel = self.viewModel?.visibleGroups?[section] else { return nil }
            view.update(with: groupViewModel)
            view.onTapDetected = {
                let result = groupViewModel.toggle(inSection: section)
                if let indexesToInsert = result.insert {
                    tableView.beginUpdates()
                    tableView.insertRows(at: indexesToInsert, with: .automatic)
                    tableView.endUpdates()
                } else if let indexesToDelete = result.delete {
                    tableView.beginUpdates()
                    tableView.deleteRows(at: indexesToDelete, with: .automatic)
                    tableView.endUpdates()
                }
            }
            view.onLongPressDetected = { [weak self] in
                self?.groupLongPressDetected(viewModel: groupViewModel)
            }
            return view
        }
        return nil
    }

    //MARK:- delegate
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let itemViewModel = self.viewModel?.itemAtIndexPath(indexPath), let cell = cell as? ControllerTableViewCell {
            cell.onLongPressDetected = { [weak self] in
                self?.itemLongPressDetected(indexPath: indexPath)
            }
            cell.update(with: itemViewModel)
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
