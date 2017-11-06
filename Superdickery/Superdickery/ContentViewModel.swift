//
//  ContentViewModel.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit

class ContentViewModel: NSObject {
    var items = [ContentElement]()
    
    static let shared = ContentViewModel()
    
    override init() {
        super.init()
    }
    
    func fetch() {
        items.removeAll()
        HTMLParser.shared.fetchPage(callback: { (success) in
            if success {
                self.items.append(ContentTitleElement(labelText: HTMLParser.shared.title))
                for each in HTMLParser.shared.imageElements {
                    self.items.append(ContentImageElement(element: each))
                }
                for each in HTMLParser.shared.labelTexts {
                    self.items.append(ContentTextElement(labelText: each))
                }
            }
        })
    }
}

extension ContentViewModel : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
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
