//
//  Contact.swift
//  RxMVVM
//
//  Created by Chedi Baccari on 21/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

enum Nationality: String {
    case tunisia, germany, usa
}

struct Contact: Hashable {
    let firstName: String
    let lastName: String
    let age: Int
    let nationality: Nationality
}
