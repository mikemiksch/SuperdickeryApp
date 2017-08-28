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
        let scaleFactor = maxWidth / self.size.width
        let height = self.size.height * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width: maxWidth, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: maxWidth, height: height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
