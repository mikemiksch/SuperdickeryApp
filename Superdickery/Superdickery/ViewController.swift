//
//  ViewController.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/14/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        let childView = self.childViewControllers[0] as! ContentViewController
        childView.activityIndicator.isHidden = false
        ContentViewModel.shared.fetch()
        childView.content?.reloadData()
        childView.viewDidLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


