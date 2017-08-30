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
        let transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        activityIndicator.transform = transform
        super.viewDidLoad()
        activityIndicator.startAnimating()
        OperationQueue.main.addOperation {
            self.loadIn()
            self.activityIndicator.isHidden = true
        }
        
    }
    
    func loadIn() {
        self.content?.estimatedRowHeight = 1000.0
        self.content?.rowHeight = UITableViewAutomaticDimension
        self.registerNibs()
        self.content?.dataSource = self
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
    
}

extension ContentViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContentViewModel.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContentViewModel.shared.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = ContentViewModel.shared.items[indexPath.section]
        switch item.type {
        case .title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as? TitleCell {
                cell.item = item
                return cell
            }
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell {
                cell.item = item
                return cell
            }
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as? TextCell {
                cell.item = item
                return cell
            }
        }
        return UITableViewCell()
    }
}


