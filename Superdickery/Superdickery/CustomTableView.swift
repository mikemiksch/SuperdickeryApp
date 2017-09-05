//
//  CustomTableView.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/31/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    override func reloadData() {
        super.reloadData()
        UIApplication.shared.endIgnoringInteractionEvents()
        print("Interaction events no longer being ignored")
    }

}
