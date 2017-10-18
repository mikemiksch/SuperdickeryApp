//
//  ViewController.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/14/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    var logo = UIImage()
    
    @IBAction func randomButtonPressed(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let childView = self.childViewControllers[0] as! ContentViewController
            childView.activityIndicator.isHidden = false
            childView.activityIndicator.startAnimating()
            randomButton.isUserInteractionEnabled = false
            print("Interaction events now being ignored")
            OperationQueue.main.addOperation {
                ContentViewModel.shared.fetch()
                childView.content?.reloadData()
                childView.viewDidLoad()
                childView.activityIndicator.stopAnimating()
                self.randomButton.isUserInteractionEnabled = true
            }
        } else {
            presentConnectionWarning()
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let shareURL = URL(string: HTMLParser.shared.shareURL)!
            let shareViewController = UIActivityViewController(activityItems: [shareURL as URL], applicationActivities: nil)
            if UIDevice.current.userInterfaceIdiom == .pad {
                shareViewController.popoverPresentationController?.sourceView = self.view
                shareViewController.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            }
            self.present(shareViewController, animated: true, completion: nil)
        } else {
            presentConnectionWarning()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo = #imageLiteral(resourceName: "Superdickery-Logo1").resizeByWidth(maxWidth: self.view.bounds.width)
        contentViewHeightConstraint.constant = logo.size.height + 20
        animateSplash()
        randomButton.layer.cornerRadius = 10
        randomButton.layer.borderWidth = 3
        randomButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 113.0/255.0, blue: 186.0/255.0, alpha: 1.0).cgColor
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderWidth = 3
        shareButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 113.0/255.0, blue: 186.0/255.0, alpha: 1.0).cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !Reachability.isConnectedToNetwork() {
            presentConnectionWarning()
        }
    }

    func animateSplash() {
        let blankBackground = UIView(frame: self.view.frame)
        blankBackground.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: self.view.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        self.view.addSubview(blankBackground)
        self.view.addSubview(imageView)
        UIView.animate(withDuration: 0.75, delay: 3.0, options: .curveEaseInOut, animations: {
            imageView.center.y = imageView.image!.size.height / 2 + 20
        }, completion: {(finished:Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                blankBackground.backgroundColor = UIColor.clear
            }, completion: {(finished: Bool) in
                blankBackground.removeFromSuperview()
            })
        })
    }
    
    func presentConnectionWarning() {
        let connectionAlert = UIAlertController(title: "No Internet Connection", message: "Please make sure your device is connected to the internet.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
        connectionAlert.addAction(okay)
        self.present(connectionAlert, animated: true, completion: nil)
    }
}


