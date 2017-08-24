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
    
    var image: UIImage
    
    init(element: Element) {
        let src = try! element.attr("src")
        let url = URL(string: src)!
        let imageData = NSData(contentsOf: url)!
        image = UIImage(data: imageData as Data)!
    }
}
