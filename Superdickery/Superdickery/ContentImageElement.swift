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
    
//    var image = UIImage()
    var src = String()
    
    init(element: Element) {
        src = try! element.attr("src")
//        imageURL = URL(string: src)!
//        let suffix = String(src.characters.suffix(4))
//        print(suffix)
//        if suffix == ".gif" {
//            // code
//        } else {
//            let imageData = NSData(contentsOf: url)!
//            image = UIImage(data: imageData as Data)!
//        }
    }
}

