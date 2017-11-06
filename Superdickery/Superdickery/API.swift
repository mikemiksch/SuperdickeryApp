//
//  API.swift
//  Superdickery
//
//  Created by Mike Miksch on 11/3/17.
//  Copyright © 2017 Superdickery. All rights reserved.
//

import Foundation

class API {
    private static let shared = API()
    let callURL = URL(string: "https://www.superdickery.com/wp-json/wp/v2/posts?filter[orderby]=rand&filter[posts_per_page]=1&categories=60")
}
