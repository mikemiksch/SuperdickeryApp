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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleText = String()
    var imageElements = [Element]()
    var textContent = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseHTML(html: fetchPage())
        titleLabel.text = titleText
        renderImages()
        
    }
    
    func fetchPage() -> String {
        let baseURL = URL(string: "http://www.superdickery.com/random/")!
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
            imageElements.append(each)
        }

        for each in pTags {
            let text = try! each.text()
            if text != "" {
                textContent.append(text)
            }
        }
    }
    
    func renderImages() {
        for each in imageElements {
            let width = Double(self.view.bounds.size.width * 0.9)
            let height = try! Double(each.attr("height"))!
//            let imageRatio = height/width
            let src = try! each.attr("src")
            let url = URL(string:src)!
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)!
                let imageView = UIImageView(frame: CGRect(x: 0, y:0, width: width, height:height))
                imageView.center = self.view.center
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    imageView.image = image
                    imageView.contentMode = UIViewContentMode.scaleAspectFit
                    self.view.addSubview(imageView)
                }
            }
        }
    }

}
