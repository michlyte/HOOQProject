//
//  MovieJSON.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import Foundation
import JSONJoy

struct MovieJSON: JSONJoy {
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: CGFloat
    var title: String
    var popularity: Double?
    var poster_path: String?
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String?
    var adult: Any
    var overview: String
    var release_date: String
    
    init(_ decoder: JSONLoader) throws {
        vote_count = try decoder["vote_count"].get()
        id = try decoder["id"].get()
        video = try decoder["video"].get()
        vote_average = try decoder["vote_average"].get()
        title = try decoder["title"].get()
        popularity = decoder["popularity"].getOptional()
        poster_path = decoder["poster_path"].getOptional()
        original_language = try decoder["original_language"].get()
        original_title = try decoder["original_title"].get()
        genre_ids = try decoder["genre_ids"].get()
        backdrop_path = decoder["backdrop_path"].getOptional()
        adult = try decoder["adult"].get()
        overview = try decoder["overview"].get()
        release_date = try decoder["release_date"].get()
    }
    
    func getReleaseDateString() -> String? {
        let releaseDate: Date? = releaseDateFormatterFromJSON.date(from: self.release_date)
        if let releaseDate = releaseDate {
            return releaseDateFormatter.string(from: releaseDate)
        } else {
            return nil
        }
    }
    
    func getReleaseYearString() -> String? {
        let releaseDate: Date? = releaseDateFormatterFromJSON.date(from: self.release_date)
        if let releaseDate = releaseDate {
            return releaseYearFormatter.string(from: releaseDate)
        } else {
            return nil
        }
    }
}
