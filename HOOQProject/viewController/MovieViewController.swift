//
//  MovieViewController.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: MovieJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let movie = movie {
            navigationItem.title = movie.original_title
            
            if let backdrop = movie.backdrop_path, let imageUrl: URL = URL(string: RestAPI.getPosterPathURL(poster_path: backdrop)) {
                movieImage.kf.setImage(with: imageUrl)
            }
            
            let releaseDate: Date? = releaseDateFormatterFromJSON.date(from: movie.release_date)
            
            var releaseYear: String = ""
            if let releaseDate = releaseDate {
                releaseYear = releaseYearFormatter.string(from: releaseDate)
                titleLabel.text = movie.title+"("+releaseYear+")"
            } else {
                titleLabel.text = movie.title
            }
            scoreLabel.text = "\(movie.vote_average)"
            overviewLabel.text = movie.overview
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
