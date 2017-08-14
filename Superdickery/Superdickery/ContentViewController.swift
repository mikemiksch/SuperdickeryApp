//
//  ContentViewController.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/8/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import Social
import SwiftSoup


class ContentViewController: UIViewController {
    
    var titleText = String()
    var imageSRC = [String]()
    var textContent = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseHTML(html: fetchPage())
        print(titleText)
        print(imageSRC)
        print(textContent)
    }
    
    func fetchPage() -> String {
        let baseURL = URL(string: "http://www.superdickery.com/stupid-sexy-wade/")!
        let data = NSData(contentsOf: baseURL)
        let html = String(data: data! as Data, encoding: .utf8)!
        return html
    }
    
    func parseHTML(html: String) {
        let html = html
        let doc : Document = try! SwiftSoup.parse(html)
        titleText = try! doc.select("h1").text()
        let images = try! doc.select(".aligncenter").array()
        let pTags = try! doc.select(".no-bottom").select("p").array()
        for each in images {
            let src = try! each.attr("src")
            imageSRC.append(src)
        }

        for each in pTags {
            let text = try! each.text()
            if text != "" {
                textContent.append(text)
            }
        }
    }
    
}
