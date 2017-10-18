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
    var shareURL = String()
    
    func fetchPage() -> String {
        let baseURL = URL(string: "http://www.superdickery.com/random")!
        let data = NSData(contentsOf: baseURL)
        let request = URLRequest(url: baseURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
        }
        task.resume()
        let html = String(data: data! as Data, encoding: .utf8)!
        return html
    }
    
    func parseHTML(html: String) {
        imageElements.removeAll()
        labelTexts.removeAll()
        let html = html
        let doc : Document = try! SwiftSoup.parse(html)
        let qfat = Array(try! doc.select("article").select(".category-qfat"))
        let blog = Array(try! doc.select("article").select(".category-blog"))
        if qfat.isEmpty && blog.isEmpty {
            title = try! doc.select("h1").text()
            if title == "Did You Know?" {
                print("Did You Know post")
                parseHTML(html: fetchPage())
            } else {
                let linkRels = try! doc.select("head").select("link").array()
                let filteredLinks = linkRels.filter { link in
                    try! link.attr("title").contains("Comments Feed")
                }
                shareURL = try! filteredLinks[1].attr("href")
                shareURL = shareURL.substring(to: shareURL.index(shareURL.endIndex, offsetBy: -5))
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
                print(title)
                if imageElements.isEmpty {
                    print("imageElements is empty")
                    parseHTML(html: fetchPage())
                }
            }
        } else {
            print("QFAT or blog post")
            parseHTML(html: fetchPage())
        }
    }
}
