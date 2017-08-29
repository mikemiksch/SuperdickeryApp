//
//  ImageCell.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/23/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import SwiftSoup

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var item: ContentElement? {
        didSet {
            guard let item = item as? ContentImageElement  else { return }
            OperationQueue.main.addOperation {
                UIImage.fetchImageWith(item.src) { (fetchedImage) in
                    self.cellImage.image = fetchedImage!.resize(maxWidth: self.bounds.size.width)
                    
                }
            }
//            cellImage.image = item.image.resize(maxWidth: (self.frame.size.width))
//                self.cellImage.image = item.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


