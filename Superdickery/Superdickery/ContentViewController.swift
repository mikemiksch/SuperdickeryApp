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
    var imageElements = [Element]()
    var textContent = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseHTML(html: fetchPage())
        renderImages()
        print(imageElements)
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
            let src = try! each.attr("src")
            let url = URL(string: src)!
            print(src)
            print(url)
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            let imageView = UIImageView(image: image)
            self.view.addSubview(imageView)
            imageView.center
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.bounds.size.width = imageView.superview!.bounds.size.width * 0.9
            
//            let widthRatio = imageView.bounds.size.width / imageView.image!.size.width
//            let heightRatio = imageView.bounds.size.height / imageView.image!.size.height
//            let imageScale = min(widthRatio, heightRatio)
//            imageView.bounds.size.width = imageView.superview.bounds.size.width * imageScale
//            imageView.bounds.size.width = imageView.image!.size.height * imageScale
            
//            let screenSize = UIScreen.main.bounds
//            let imageSize = CGSize(width: screenSize.width * 0.9, height: CGFloat(imgHeight! * imgRatio))
//            imageView.frame = CGRect(dictionaryRepresentation: imageSize as! CFDictionary)!
        }
    }

}
