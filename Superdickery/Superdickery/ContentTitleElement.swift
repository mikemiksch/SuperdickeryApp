//
//  ContentTitleElement.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation

class ContentTitleElement : ContentElement {
    var type: ContentElementType {
        return .title
    }
    
    var labelText: String
    
    init(labelText: String) {
        self.labelText = labelText
    }
}
