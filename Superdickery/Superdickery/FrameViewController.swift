//
//  FrameViewController.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/14/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class FrameViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var randomButton: UIButton!
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        let childView = self.childViewControllers[0] as! ContentViewController
        childView.activityIndicator.isHidden = false
        ContentViewModel.shared.fetch()
        childView.content?.reloadData()
    }
    
    static let shared = FrameViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    public func toggleRandomButton() {
//        if randomButton.isEnabled == true {
//            randomButton.isEnabled = false
//        } else {
//            randomButton.isEnabled = true
//        }
//    }

}


