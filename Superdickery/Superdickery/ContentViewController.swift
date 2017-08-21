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
    @IBOutlet weak var scrollView: UIScrollView!
    
    var titleText = String()
    var imageElements = [Element]()
    var textContent = [String]()
    var contentHeight = 0
    var imageViews = [UIImageView]()
    var labels = [UILabel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseHTML(html: fetchPage())
        titleLabel.text = titleText
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize.width = self.view.bounds.width
        scrollView.contentSize.height = 1000
        generateImageViews() { result in
            setImageViewConstraints()
        }
//        setImageViewConstraints()
        
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
    
    func generateImageViews(completion: () -> Void ) {
        for each in imageElements {
            let width = Double(self.view.bounds.size.width * 0.9)
            let height = try! Double(each.attr("height"))!
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
                    self.imageViews.append(imageView)
                    print("here are image views when it should be appended: \(self.imageViews)")
//                    self.view.addSubview(imageView)
                }
            }
        }

    }

    func setImageViewConstraints () {
        print("Here are image views when ImageView Constraints is called \(self.imageViews)")
        if !self.imageViews.isEmpty {
            print("Hi there!")
            scrollView.addSubview(imageViews[0])
            let topConstraint = NSLayoutConstraint(item: imageViews[0], attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 20.0)
            scrollView.addConstraint(topConstraint)
        }
    }
}
    
