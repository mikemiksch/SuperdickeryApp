//
//  ContentVideoElement.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation

class ContentVideoElement : ContentElement {
    var type: ContentElementType {
        return .video
    }
    
    var URLString: String
    
    init(url: String) {
        self.URLString = url
    }
}
