//
//  NowPlayingTableViewController.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import UIKit
import Alamofire
import JSONJoy
import Kingfisher

class NowPlayingTableViewController: UITableViewController {
    
    // MARK: Properties
    private let movieSegue: String = "movieSegue"
    
    private var datasource: NowPlayingMovieJSON?
    private var page: String = "1"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.backgroundColor = ColorUtil.black
    
        Alamofire.request(RestAPI.getNowPlayingMovieURL(), method: .get, parameters: RestAPI.getParams(page: page) , encoding: URLEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let result):
                    //do the checking with expected result
                    //AssertEqual or whatever you need to do with the data
                    //finally fullfill the expectation
                    do {
                        self.datasource = try NowPlayingMovieJSON(JSONLoader(result))
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("unable to parse the JSON")
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = datasource?.results {
            return results.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell,
            let datasource = datasource {

            let movieJSON = datasource.results[indexPath.row]
            if let poster = movieJSON.poster_path, let imageUrl: URL = URL(string: RestAPI.getPosterPathURL(poster_path: poster)) {
                movieCell.movieImage.kf.setImage(with: imageUrl, placeholder: ImageUtil.noPosterImage, options: [.transition(.fade(0.2))])
            }
            movieCell.titleLabel.text = movieJSON.title
            movieCell.overviewLabel.text = movieJSON.overview
            movieCell.scoreLabel.text = "\(movieJSON.vote_average)"
            movieCell.releaseDateLabel.text = movieJSON.getReleaseDateString() ?? movieJSON.release_date
            
            return movieCell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let datasource = datasource {
            performSegue(withIdentifier: movieSegue, sender: datasource.results[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let datasource = datasource, let pageNum = Int(page), pageNum < datasource.total_pages {
            let lastElement = datasource.results.count - 1
            
            if indexPath.row == lastElement {
                self.page = "\(pageNum + 1)"
                retrieveNowPlaying(page: self.page)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == movieSegue {
            if let movieViewController = segue.destination as? MovieViewController, let movie = sender as? MovieJSON {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = UIBarButtonItem()
                
                movieViewController.movie = movie
            }
        }
    }
    
    // MARK: Private Methods
    fileprivate func retrieveNowPlaying(page: String) {
        Alamofire.request(RestAPI.getNowPlayingMovieURL(), method: .get, parameters: RestAPI.getParams(page: page) , encoding: URLEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let result):
                    //do the checking with expected result
                    //AssertEqual or whatever you need to do with the data
                    //finally fullfill the expectation
                    do {
                        let newDatasource = try NowPlayingMovieJSON(JSONLoader(result))

                        switch page {
                        case "1":
                            self.datasource = newDatasource
                        default:
                            self.datasource?.results.append(contentsOf: newDatasource.results)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
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
