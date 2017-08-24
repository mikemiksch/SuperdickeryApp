//
//  titleCell.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/23/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var item: ContentElement? {
        didSet {
            print("didSet titleCell")
            guard let item = item as? ContentTitleElement  else { return }
            titleLabel.text = item.labelText
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
