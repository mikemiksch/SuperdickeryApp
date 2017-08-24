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
            cellImage.contentMode = UIViewContentMode.scaleAspectFit
            if item.image.size.width <= self.bounds.size.width {
                cellImage.image = item.image
            } else {
                cellImage.image = item.image.resize(maxWidth: self.bounds.size.width)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Cell size: \(self.bounds.size.width)")
    }
}
////
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

