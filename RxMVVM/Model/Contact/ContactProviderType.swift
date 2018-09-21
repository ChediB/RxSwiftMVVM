//
//  ContactProvider.swift
//  RxMVVM
//
//  Created by Chedi Baccari on 21/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation
import RxSwift

protocol ContactProviderType {
    
    var contacts: Observable<Set<Contact>> {get}
}
