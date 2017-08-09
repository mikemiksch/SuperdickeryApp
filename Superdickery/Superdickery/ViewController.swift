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
    
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPage()
    }
    
    func fetchPage() {
        let baseURL = URL(string: "http://www.superdickery.com/random")!
        let downloadTask = session.downloadTask(with: baseURL, completionHandler: { (location, response, error) -> Void in
            if error == nil {
                let data = NSData(contentsOf: location!)
                let tempData = String(data: data! as Data, encoding: .utf8)
                print(tempData ?? String(describing: error))
            }
        })
        downloadTask.resume()
    }
    
}

