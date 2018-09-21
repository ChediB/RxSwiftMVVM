//
//  ContactViewModel.swift
//  RxMVVM
//
//  Created by Chedi Baccari on 21/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContactViewModel: Contactable {
    
    let datasource: Driver<[TableDatasource.Section]>
    
    init(_ provider: ContactProviderType) {
        self.datasource = provider
            .contacts
            .map { items -> [TableDatasource.Section] in
                let grouped = Dictionary(grouping: items) { $0.lastName.first! }
                let keys = grouped.keys.sorted()
                return keys.map { key -> TableDatasource.Section in
                    let rows = grouped[key]?.compactMap(ContactRow.init) ?? []
                    return TableDatasource.Section(title: String(key), rows: rows)
                }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
