//
//  MovieJSON.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import Foundation
import JSONJoy

struct Movie: JSONJoy {
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: Float
    var title: String
    var popularity: Float
    var poster_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var release_date: String
    
    init(_ decoder: JSONLoader) throws {
        vote_count = try decoder["vote_count"].get()
        id = try decoder["id"].get()
        video = try decoder["video"].get()
        vote_average = try decoder["vote_average"].get()
        title = try decoder["title"].get()
        popularity = try decoder["popularity"].get()
        poster_path = try decoder["poster_path"].get()
        original_language = try decoder["original_language"].get()
        original_title = try decoder["original_title"].get()
        genre_ids = try decoder["genre_ids"].get()
        backdrop_path = try decoder["backdrop_path"].get()
        adult = try decoder["adult"].get()
        overview = try decoder["overview"].get()
        release_date = try decoder["release_date"].get()
    }
}
