//
//  SearchViewModel.swift
//  CodableUnsplash
//
//  Created by Justin Powell on 6/27/18.
//  Copyright © 2018 Justin Powell. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewModel: NSObject {

    var query = Variable<String>("")
    let placeholder: String

    init(placeholder: String = "Search") {
        self.placeholder = placeholder
        super.init()
    }

    func searchQuery() {}
}
