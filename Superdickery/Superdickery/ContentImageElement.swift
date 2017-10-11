//
//  ContentImageElement.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation
import SwiftSoup

class ContentImageElement : ContentElement {
    var type: ContentElementType {
        return .image
    }

    var src = String()
    
    init(element: Element) {
        src = try! element.attr("src")
    }
}

