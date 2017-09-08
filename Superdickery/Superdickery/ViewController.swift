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
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    var logo = UIImage()
    
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
        logo = #imageLiteral(resourceName: "Superdickery-Logo1").resize(maxWidth: self.view.bounds.width)
        contentViewHeightConstraint.constant = logo.size.height + 20
        animateSplash()
    }
    
    
    func animateSplash() {
        let blankBackground = UIView(frame: self.view.frame)
        blankBackground.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: self.view.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        self.view.addSubview(blankBackground)
        self.view.addSubview(imageView)
        UIView.animate(withDuration: 0.5, delay: 3.0, options: .curveEaseOut, animations: {
            imageView.center.y = imageView.image!.size.height / 2 + 20
        }, completion: {(finished:Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                blankBackground.backgroundColor = UIColor.clear
            }, completion: {(finished: Bool) in
                blankBackground.removeFromSuperview()
            })
        })
        
    }

}


