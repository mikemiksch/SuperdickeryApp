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
    @IBOutlet weak var logo: UIImageView!
    
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
        animateSplash()

    }
    
    
    func animateSplash() {
        let blankBackground = UIView(frame: self.view.frame)
        blankBackground.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = #imageLiteral(resourceName: "Superdickery-Logo1").resize(maxWidth: self.view.bounds.width)
        imageView.contentMode = .scaleAspectFit
        blankBackground.addSubview(imageView)
        self.view.addSubview(blankBackground)
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
            imageView.center.y = imageView.center.y - 20
            imageView.center.y = self.logo.center.y
        }, completion: {(finished:Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                blankBackground.backgroundColor = UIColor.clear
            }, completion: {(finished: Bool) in
                blankBackground.removeFromSuperview()
            })
        })
        
    }

}


