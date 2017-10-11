//
//  UIExtensions.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/23/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import Gifu

extension UIImage {
    
    typealias ImageCallback = (UIImage?)->()
    
//    class func fetchImageWith(_ urlString : String, callback: @escaping ImageCallback) {
//        OperationQueue().addOperation {
//            guard let url = URL(string: urlString) else { callback(nil); return }
//            if let data = try? Data(contentsOf: url) {
//                let image = UIImage(data: data)
//                OperationQueue.main.addOperation {
//                    callback(image)
//                    print("Called back image")
//                }
//            }
//        }
//    }
    
    func resizeByWidth(maxWidth: CGFloat) -> UIImage {
        let scaleFactor = maxWidth / self.size.width
        let height = self.size.height * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width: maxWidth, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: maxWidth, height: height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
//    func resizeByHeight() -> UIImage {
//        let scaleFactor = 700 / self.size.height
//        let width = self.size.width * scaleFactor
//        
//        UIGraphicsBeginImageContext(CGSize(width: width, height: 700))
//        self.draw(in: CGRect(x: 0, y: 0, width: width, height: 700))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return resizedImage!
//    }
}

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}

extension UIImageView: GIFAnimatable {
    private struct AssociatedKeys {
        static var AnimatorKey = "gifu.animator.key"
    }
    
    override open func display(_ layer: CALayer) {
        updateImageIfNeeded()
    }
    
    public var animator: Animator? {
        get {
            guard let animator = objc_getAssociatedObject(self, &AssociatedKeys.AnimatorKey) as? Animator else {
                let animator = Animator(withDelegate: self)
                self.animator = animator
                return animator
            }
            
            return animator
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.AnimatorKey, newValue as Animator?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
