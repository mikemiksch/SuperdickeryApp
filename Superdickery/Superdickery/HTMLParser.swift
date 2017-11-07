//
//  HTMLParser.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import SwiftSoup
import SwiftyJSON

class HTMLParser {
    static let shared = HTMLParser()
    
    var title = String()
    var imageElements = [Element]()
    var labelTexts = [String]()
    var shareURL = String()
    
    func fetchPage(callback: @escaping (Bool) -> ()) {
        imageElements.removeAll()
        labelTexts.removeAll()
        guard let callURL = URL(string: "https://www.superdickery.com/wp-json/wp/v2/posts?filter[orderby]=rand&filter[posts_per_page]=1&categories=60") else { return }
        URLSession.shared.dataTask(with: callURL) { (data, response, error) in
            if let error = error {
                print("Error retrieving data from API call: \(error.localizedDescription)")
                return
            }
            guard response != nil else { return }
            guard let data = data else { return }
            
            let json = JSON(data: data)
            
            self.shareURL = json[0]["link"].string!
            self.title = json[0]["title"]["rendered"].string!.stringByDecodingHTMLEntities
            
            let html = json[0]["content"]["rendered"].string!
            let doc : Document = try! SwiftSoup.parse(html)
            let images = try! doc.select(".aligncenter").array()
            let pTags = try! doc.select("p").array()
            for each in images {
                self.imageElements.append(each)
            }
            for each in pTags {
                let text = try! each.text()
                if text != "" {
                    self.labelTexts.append(text)
                }
            }
            callback(true)
        }.resume()
        
        // This line shouldn't even be doing anything, and yet it keeps the content from displaying if it's removed?
        let data = NSData(contentsOf: URL(string: "http://www.superdickery.com/random")!)
    }
}
