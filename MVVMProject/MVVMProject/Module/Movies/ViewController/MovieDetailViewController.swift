//
//  MovieDetailViewController.swift
//  MVVMProject
//
//  Created by Vartika on 22/01/21.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    var movieInfo: Data? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if movieInfo?.title == nil || movieInfo?.title == "" {
            self.navigationItem.title = movieInfo?.name
        } else {
            self.navigationItem.title = movieInfo?.title
        }
        setUpView()
    }
    
    func setUpView() {
        if MovieListActions().checkIfAlreadyExists(movieInfo?.id ?? 0) {
            self.addToFavButton.tintColor = UIColor.green
            self.addToFavButton.setImage(UIImage.init(systemName: "checkmark"), for: .normal)
        } else {
            self.addToFavButton.tintColor = .black
            self.addToFavButton.setImage(UIImage.init(systemName: "plus"), for: .normal)
        }
        if movieInfo?.overview == "" {
            movieDescription.text = "A Must Great Movie to watch as suggested by \(String(describing: (movieInfo?.voteCount)!)) users"
        } else {
            movieDescription.text = movieInfo?.overview
        }
        if movieInfo?.backdropPath != nil || movieInfo?.backdropPath == "" {
            let posterURL = String(describing: (movieInfo?.backdropPath ?? "")!)
            let URL = "https://image.tmdb.org/t/p/w500\(posterURL)"
            AF.request(URL).responseImage { response in
                if case .success(let image) = response.result {
                    self.moviePoster.image = image
                } else {
                    self.moviePoster.image = #imageLiteral(resourceName: "imdb")
                }
            }
        }
        if movieInfo?.releaseDate != nil || movieInfo?.releaseDate == "" {
            movieYear.text = String(movieInfo?.releaseDate?.prefix(4) ?? "2020")
        } else {
            movieYear.text = String(movieInfo?.firstAirDate?.prefix(4) ?? "2020")
        }
        movieRating.text = String(movieInfo?.voteAverage ?? 0)
        if movieInfo?.originalLanguage == "en" {
            movieLanguage.text = "English"
        } else {
            movieLanguage.text = "Others"
        }
    }
    
    @IBAction func addToFavouriteButton(_ sender: Any) {
        if MovieListActions().checkIfAlreadyExists(movieInfo?.id ?? 0) {
            MovieListActions().deleteFromList(movieInfo?.id ?? 0)
            self.addToFavButton.tintColor = .black
            self.addToFavButton.setImage(UIImage.init(systemName: "plus"), for: .normal)
        } else {
            self.addToFavButton.setImage(UIImage.init(systemName: "checkmark"), for: .normal)
            self.addToFavButton.tintColor = .green
            MovieListActions().insertData(movieInfo)
        }
    }
}
