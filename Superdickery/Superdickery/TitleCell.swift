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
            guard let item = item as? ContentTitleElement  else { return }
            titleLabel.text = item.labelText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
