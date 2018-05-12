//
//  SimilarMovieJSON.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import Foundation
import JSONJoy

struct SimilarMovieJSON: JSONJoy {
    var page: Int
    var results: [MovieJSON]
    var total_pages: Int
    var total_results: Int
    
    init(_ decoder: JSONLoader) throws {
        page = try decoder["page"].get()
        results = try decoder["results"].get()
        total_pages = try decoder["total_pages"].get()
        total_results = try decoder["total_results"].get()
    }
}
