//
//  MovieViewController.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import UIKit
import Alamofire
import JSONJoy
import Kingfisher
import Cosmos

class MovieViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var relatedMovieLabel: UILabel!
    @IBOutlet weak var relatedMovieCollectionView: UICollectionView!
    
    var movie: MovieJSON?
    
    private var datasource: SimilarMovieJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleUI()
        fillUI()
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

    // MARK: Private Methods
    fileprivate func styleUI() {
        view.backgroundColor = ColorUtil.black
        scrollView.indicatorStyle = .white
        contentView.backgroundColor = ColorUtil.black
        
        titleLabel.textColor = ColorUtil.red
        scoreLabel.textColor = ColorUtil.white
        voteCountLabel.textColor = ColorUtil.white
        overviewTitleLabel.textColor = ColorUtil.white
        overviewLabel.textColor = ColorUtil.white
        relatedMovieLabel.textColor = ColorUtil.white
        
        relatedMovieCollectionView.backgroundColor = ColorUtil.black
    }
    
    fileprivate func fillUI() {
        if let movie = movie {
            navigationItem.title = movie.title
            
            if let backdrop = movie.backdrop_path, let imageUrl: URL = URL(string: RestAPI.getPosterPathURL(poster_path: backdrop)) {
                movieImage.kf.setImage(with: imageUrl, placeholder: ImageUtil.noBackdropImage)
            }
            
            let releaseYear: String? = movie.getReleaseYearString()
            if let releaseYear = releaseYear {
                titleLabel.text = movie.title+"("+releaseYear+")"
            } else {
                titleLabel.text = movie.title
            }
            scoreLabel.text = "\(movie.vote_average)"
            ratingView.rating = Double(movie.vote_average / 10 * 5)
            voteCountLabel.text = "(\(movie.vote_count))"
            
            overviewLabel.text = movie.overview
            
            Alamofire.request(RestAPI.getSimilarMovieURL(movie_id: "\(movie.id)"), method: .get, parameters: RestAPI.getParams(page: "1"), encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let result):
                        //do the checking with expected result
                        //AssertEqual or whatever you need to do with the data
                        //finally fullfill the expectation
                        do {
                            self.datasource = try SimilarMovieJSON(JSONLoader(result))
                            
                            DispatchQueue.main.async {
                                self.relatedMovieCollectionView.reloadData()
                            }
                        } catch {
                            print("unable to parse the JSON")
                        }
                    case .failure(let error):
                        print(error)
                    }
                })
        }
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let datasource = datasource {
            return datasource.results.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell {
            
            if let datasource = datasource, let poster = datasource.results[indexPath.row].poster_path, let imageUrl: URL = URL(string: RestAPI.getPosterPathURL(poster_path: poster)) {
                movieCell.movieImage.kf.setImage(with: imageUrl, placeholder: ImageUtil.noPosterImage)
            }
            
            return movieCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieVC: MovieViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController, let datasource = datasource {
            movieVC.movie = datasource.results[indexPath.row]
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = UIBarButtonItem()
            
            navigationController?.pushViewController(movieVC, animated: true)
        }
    }
}
