//
//  MovieNowPlayingJSON.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import Foundation
import JSONJoy

struct NowPlayingMovieJSON: JSONJoy {
    var results: [MovieJSON]
    var page: Int
    var total_results: Int
    var total_pages: Int
    
    init(_ decoder: JSONLoader) throws {
        results = try decoder["results"].get()
        page = try decoder["page"].get()
        total_results = try decoder["total_results"].get()
        total_pages = try decoder["total_pages"].get()
    }
}
