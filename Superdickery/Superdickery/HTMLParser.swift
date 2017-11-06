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
    
    func fetchPage() -> String {
        imageElements.removeAll()
        labelTexts.removeAll()
        guard let callURL = URL(string: "https://www.superdickery.com/wp-json/wp/v2/posts?filter[orderby]=rand&filter[posts_per_page]=1&categories=60") else { return "Error" }
        URLSession.shared.dataTask(with: callURL) { (data, response, error) in
            if let error = error {
                print("Error retrieving data from API call: \(error.localizedDescription)")
                return
            }
            guard response != nil else { return }
            guard let data = data else { return }
            
            let json = JSON(data: data)
            
            self.shareURL = json[0]["link"].string!
            self.title = json[0]["title"]["rendered"].string!
            
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
            
            print(self.imageElements)
            print(self.labelTexts)
        }.resume()
        
        
        
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
    
//    func parseHTML(html: String) {
//        imageElements.removeAll()
//        labelTexts.removeAll()
//        let html = html
//        let doc : Document = try! SwiftSoup.parse(html)
//        let qfat = Array(try! doc.select("article").select(".category-qfat"))
//        let blog = Array(try! doc.select("article").select(".category-blog"))
//        if qfat.isEmpty && blog.isEmpty {
//            title = try! doc.select("h1").text()
//            if title == "Did You Know?" {
//                print("Did You Know post")
//                parseHTML(html: fetchPage())
//            } else {
//                let linkRels = try! doc.select("head").select("link").array()
//                let filteredLinks = linkRels.filter { link in
//                    try! link.attr("title").contains("Comments Feed")
//                }
//                shareURL = try! filteredLinks[1].attr("href")
//                shareURL = shareURL.substring(to: shareURL.index(shareURL.endIndex, offsetBy: -5))
//                let images = try! doc.select(".aligncenter").array()
//                let pTags = try! doc.select(".no-bottom").select("p").array()
//                for each in images {
//                    imageElements.append(each)
//                }
//                for each in pTags {
//                    let text = try! each.text()
//                    if text != "" && text != "Source" && text != "Unsourced" && !text.contains("©") {
//                        labelTexts.append(text)
//                    }
//                }
//                print(title)
//                if imageElements.isEmpty {
//                    print("imageElements is empty")
//                    parseHTML(html: fetchPage())
//                }
//            }
//        } else {
//            print("QFAT or blog post")
//            parseHTML(html: fetchPage())
//        }
//    }
}
