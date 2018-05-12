//
//  Constants.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import Foundation

struct RestAPI {
    static func getBaseURL() -> String {
        return "https://api.themoviedb.org/3"
    }
    
    static func getLanguage() -> String {
        return "en-US"
    }
    
    static func getAPIKey() -> String {
        return "081da61c6bb19529ca70f541b168f628"
    }
    
    static func getParams(page: String) -> [String: String] {
        return [
            "api_key": getAPIKey(),
            "language": getLanguage(),
            "page": page
        ]
    }
    
    static func getPosterPathURL(poster_path: String) -> String {
        return "https://image.tmdb.org/t/p/w500"+poster_path
    }
    
    static func getNowPlayingMovieURL() -> String {
        return getBaseURL()+"/movie/now_playing"
    }
    
    static func getSimilarMovieURL(movie_id: String) -> String {
        return getBaseURL()+"/movie/"+movie_id+"/similar"
    }
}
