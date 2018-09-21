//
//  ViewController.swift
//  RxMVVM
//
//  Created by Chedi Baccari on 21/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private var bag = DisposeBag()
    private var contactViewModel: Contactable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactViewModel = ContactViewModel(ContactProvider())
        self.configure()
    }

    private func configure() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 768, height: 1024), style: .plain)
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactRow.cellIdentifier)
        /// Here goes the magical binding
        contactViewModel
            .datasource
            .drive(tableView.rx.items(dataSource: TableDatasource()))
            .disposed(by: bag)
        
        view.addSubview(tableView)
    }
}

