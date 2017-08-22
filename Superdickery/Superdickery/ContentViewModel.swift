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
    
    override init() {
        super.init()
        let html = HTMLParser.shared.fetchPage()
        HTMLParser.shared.parseHTML(html: html)
        items.append(ContentTitleElement(labelText: HTMLParser.shared.title))
        for each in HTMLParser.shared.imageElements {
            items.append(ContentImageElement(element: each))
        }
        for each in HTMLParser.shared.labelTexts {
            items.append(ContentTextElement(labelText: each))
        }
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
        return UITableViewCell()
    }
}
