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
        refreshContent()
        formatTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        activityIndicator.isHidden = true
    }
    
    func formatTable() {
        self.content?.estimatedRowHeight = 1000.0
        self.content?.rowHeight = UITableViewAutomaticDimension
        self.registerNibs()
        self.content?.dataSource = ContentViewModel.shared
        self.content?.separatorStyle = .none
    }
    
    func refreshContent() {
        if Reachability.isConnectedToNetwork() {
            let transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            activityIndicator.transform = transform
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            DispatchQueue.main.async {
                ContentViewModel.shared.fetch()
                self.content?.reloadData()
                self.content?.setContentOffset(.zero, animated: false)
                self.activityIndicator.isHidden = true
                let parent = self.parent as! ViewController
                parent.randomButton.isUserInteractionEnabled = true
                print("Random button reenabled")
            }
            
        }
    }
    
    func registerNibs() {
        let titleNib = UINib(nibName: "TitleCell", bundle: nil)
        let imageNib = UINib(nibName: "ImageCell", bundle: nil)
        let textNimb = UINib(nibName: "TextCell", bundle: nil)
        self.content?.register(titleNib, forCellReuseIdentifier: TitleCell.identifier)
        self.content?.register(imageNib, forCellReuseIdentifier: ImageCell.identifier)
        self.content?.register(textNimb, forCellReuseIdentifier: TextCell.identifier)
    }
    
}
