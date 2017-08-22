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
        renderImages()
        
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
        let group = DispatchGroup()
        group.enter()
        for each in imageElements {
            let width = Double(self.view.bounds.size.width * 0.9)
            let height = try! Double(each.attr("height"))!
            let src = try! each.attr("src")
            let url = URL(string:src)!
            let imageData = NSData(contentsOf: url)!
            let imageView = UIImageView(frame: CGRect(x: 0, y:0, width: width, height:height))
//            imageView.center = self.view.center
            let image = UIImage(data: imageData as Data)
            imageView.image = image
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.imageViews.append(imageView)
            
        }
        group.leave()
        group.notify(queue: DispatchQueue.main) {
            self.setImageViewConstraints()
        }

    }

    func setImageViewConstraints() {
        if !self.imageViews.isEmpty {
            var previous = UIImageView()
            for each in imageViews {
                scrollView.addSubview(each)
//                each.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//                let centerX = NSLayoutConstraint(item: each, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 1)
//                if each === imageViews.first {
//                    let topConstraint = NSLayoutConstraint(item: each, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 8.0)
//                    scrollView.addConstraint(topConstraint)
//                    previous = each
//                    
//                } else {
//                    let topConstraint = NSLayoutConstraint(item: each, attribute: .top, relatedBy: .equal, toItem: previous, attribute: .bottom, multiplier: 1.0, constant: 8.0)
//                    scrollView.addConstraint(topConstraint)
//                    scrollView.addConstraint(centerX)
//                    previous = each
//                }
            }
        }
    }
}
