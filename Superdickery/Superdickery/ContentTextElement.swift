//
//  ContentTextElement.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation

class ContentTextElement : ContentElement {
    var type: ContentElementType {
        return .text
    }
    
    var labelText: String
    
    init(labelText: String) {
        self.labelText = labelText
    }
}
