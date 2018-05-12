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
    var results: [Movie]
    
    init(_ decoder: JSONLoader) throws {
        results = try decoder["results"].get()
    }
}
