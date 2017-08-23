//
//  textCell.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/23/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var textElementLabel: UILabel!

    
    var item: ContentElement? {
        didSet {
            guard let item = item as? ContentTextElement else { return }
            self.textElementLabel.text = item.labelText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
