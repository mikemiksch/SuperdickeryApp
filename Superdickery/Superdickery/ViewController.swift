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
    @IBOutlet weak var randomButton: UIButton!
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        print("Interaction events now being ignored")
        let childView = self.childViewControllers[0] as! ContentViewController
        childView.activityIndicator.startAnimating()
        OperationQueue.main.addOperation {
            ContentViewModel.shared.fetch()
            childView.content?.reloadData()
            childView.viewDidLoad()
            childView.activityIndicator.stopAnimating()
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


