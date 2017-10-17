//
//  ViewController.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/14/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var content: UITableView?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        activityIndicator.isHidden = true
        if Reachability.isConnectedToNetwork() {
            let transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            activityIndicator.transform = transform
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            OperationQueue.main.addOperation {
                self.loadIn()
                self.content?.reloadData()
                self.activityIndicator.isHidden = true
//                let parent = self.parent as! ViewController
//                parent.randomButton.isUserInteractionEnabled = true
//                print("No longer ignoring user interaction events")
            }

        } else {
            let connectionAlert = UIAlertController(title: "No Internet Connection", message: "Please make sure your device is connected to the internet.", preferredStyle: .alert)
            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
            connectionAlert.addAction(okay)
            self.present(connectionAlert, animated: true, completion: nil)
        }
    }
    
    func loadIn() {
        self.content?.estimatedRowHeight = 1000.0
        self.content?.rowHeight = UITableViewAutomaticDimension
        self.registerNibs()
        self.content?.dataSource = ContentViewModel.shared
        self.content?.separatorStyle = .none
    }
    
    func registerNibs() {
        let titleNib = UINib(nibName: "TitleCell", bundle: nil)
        let imageNib = UINib(nibName: "ImageCell", bundle: nil)
        let textNimb = UINib(nibName: "TextCell", bundle: nil)
        self.content?.register(titleNib, forCellReuseIdentifier: TitleCell.identifier)
        self.content?.register(imageNib, forCellReuseIdentifier: ImageCell.identifier)
        self.content?.register(textNimb, forCellReuseIdentifier: TextCell.identifier)
    }
    
//    func checkConnectivity() -> Bool {
//        if currentReachabilityStatus == .notReachable {
//            let connectionAlert = UIAlertController(title: "No Internet Connection", message: "Please make sure your device is connected to the internet.", preferredStyle: .alert)
//            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
//            connectionAlert.addAction(okay)
//            self.present(connectionAlert, animated: true, completion: nil)
//            return false
//        } else {
//            return true
//        }
//    }
    
}
