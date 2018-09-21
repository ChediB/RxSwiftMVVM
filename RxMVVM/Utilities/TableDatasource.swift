//
//  TableDatasource.swift
//  RxMVVM
//
//  Created by Chedi Baccari on 21/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// The RxSwiftbase implementation for UITableView doesn’t support the multi section UITableView
// For this task I want to stick with only RxSwift so we are going to implement a utility Class
// called TableDatasource that will help us harness the multi section requirement

class TableDatasource: NSObject, UITableViewDataSource, RxTableViewDataSourceType, SectionedViewDataSourceType, UITableViewDelegate {
    struct Section {
        let title: String
        let rows: [TableRow]
        
        init(title: String, rows: [TableRow]) {
            self.title = title
            self.rows = rows
        }
    }
    
    private var _model: [Section] = []
    
    typealias Element = [Section]
    func tableView(_ tableView: UITableView, observedEvent: Event<[TableDatasource.Section]>) {
        Binder(self) {form, sections in
            form._model = sections
            tableView.reloadData()
            }
            .on(observedEvent)
    }
    
    func model(at indexPath: IndexPath) throws -> Any {
        return _model[indexPath.section].rows[indexPath.row]
    }
    //MARK: Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return _model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < _model.count else { return 0 }
        return _model[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = _model[indexPath.section].rows[indexPath.row]
        return item.configuredCell(item.cellId, nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < _model.count else { return nil }
        return _model[section].title
    }
}

protocol TableRow {
    var configuredCell: (_ id: String, _ cell: UITableViewCell?) -> UITableViewCell { get }
    static var cellIdentifier: String {get}
}

extension TableRow {
    var cellId: String { return Self.cellIdentifier }
}

class ContactCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle = .value2, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bind(_ model: Contact) {
        self.textLabel?.text = model.firstName
        self.detailTextLabel?.text = model.lastName
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.selectionStyle = .none
    }
}
// ContactRow
struct ContactRow: TableRow {
    static var cellIdentifier: String { return "ContactRowCell" }
    let configuredCell: (_ id: String, _ cell: UITableViewCell?) -> UITableViewCell
    
    init(_ model: Contact) {
        configuredCell = { id, cell in
            guard let cell = cell as? ContactCell else {
                let cell = ContactCell(style: .value2, reuseIdentifier: id)
                cell.bind(model)
                return cell
            }
            cell.bind(model)
            return cell
        }
    }
}
