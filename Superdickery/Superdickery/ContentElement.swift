//
//  ContentElement.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation

protocol ContentElement {
    var type: ContentElementType { get }
    var rowCount: Int { get }
}

extension ContentElement {
    var rowCount: Int {
        return 1
    }
}
