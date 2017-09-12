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
    
    var item: ContentElement? {
        didSet {
            guard let item = item as? ContentImageElement  else { return }
                let suffix = String(item.src.characters.suffix(4))
                let imageData = NSData(contentsOf: URL(string: item.src)!)
                if suffix == ".gif" {
                    cellImage.animate(withGIFData: imageData! as Data)
                } else {
                    let image = UIImage(data: imageData! as Data)
                    cellImage.image = image?.resizeByWidth(maxWidth: self.bounds.size.width)
                }
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.contentMode = .scaleAspectFit
    }
}


