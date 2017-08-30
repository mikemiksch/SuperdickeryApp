//
//  HTMLParser.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/22/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import SwiftSoup

class HTMLParser {
    static let shared = HTMLParser()
    
    var title = String()
    var imageElements = [Element]()
    var labelTexts = [String]()
    
    func fetchPage() -> String {
        let baseURL = URL(string: "http://www.superdickery.com/random")!
        let data = NSData(contentsOf: baseURL)
        let html = String(data: data! as Data, encoding: .utf8)!
        return html
    }
    
    func parseHTML(html: String) {
        imageElements.removeAll()
        labelTexts.removeAll()
        let html = html
        let doc : Document = try! SwiftSoup.parse(html)
        title = try! doc.select("h1").text()
        print(title)
        let images = try! doc.select(".aligncenter").array()
        let pTags = try! doc.select(".no-bottom").select("p").array()
        for each in images {
            imageElements.append(each)
        }
        for each in pTags {
            let text = try! each.text()
            if text != "" && text != "Source" && text != "Unsourced" && !text.contains("©") {
                labelTexts.append(text)
            }
        }
        if imageElements.isEmpty || labelTexts.isEmpty {
            parseHTML(html: fetchPage())
        }
    }
}
