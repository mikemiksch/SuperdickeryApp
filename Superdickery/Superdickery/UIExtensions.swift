//
//  UIExtensions.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/23/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

import UIKit

extension UIImage {
    
    typealias ImageCallback = (UIImage?)->()
    
    class func fetchImageWith(_ urlString : String, callback: @escaping ImageCallback) {
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { callback(nil); return }
            
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                OperationQueue.main.addOperation {
                    callback(image)
                }
            }
        }
    }
    
    func resize(maxWidth: CGFloat) -> UIImage {
        let size = self.size
        let ratio = size.height / size.width
        var newSize = CGSize()
        if size.width > maxWidth {
            newSize = CGSize(width: maxWidth, height: maxWidth * ratio)
        } else {
            newSize = CGSize(width: size.width, height: size.height)
        }
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: newRect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(maxWidth)
        print(self.size.width)
        return resizedImage!
    }
    
}

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
