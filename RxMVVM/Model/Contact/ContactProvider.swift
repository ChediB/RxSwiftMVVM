//
//  ContactProvider.swift
//  RxMVVM
//
//  Created by Chedi Baccari on 21/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RxSwift

class ContactProvider: ContactProviderType {
    let contacts: Observable<Set<Contact>>
    
    init() {
        self.contacts = Observable.just([
            Contact(firstName: "Angela", lastName: "Merkel", age: 64, nationality: .germany),
            Contact(firstName: "Chedi", lastName: "Baccari", age: 26, nationality: .tunisia),
            Contact(firstName: "Slim", lastName: "Shady", age: 46, nationality: .usa)
            ])
    }
}
