//
//  ViewController.swift
//  Superdickery
//
//  Created by Mike Miksch on 8/8/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import UIKit
import Social
import SwiftSoup


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseHTML(html: fetchPage())
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
        let title = try! doc.select("h1").text()
        let images = try! doc.select(".aligncenter").array()
        let text = try! doc.select(".no-bottom").select("p").text().lines
        print(title)
//        for each in images {
//            let src = try! each.attr("src")
//            print(src)
//        }
        print(text)
    }
    
}

extension String {
    var lines: [String] {
        var result = [String]()
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}
