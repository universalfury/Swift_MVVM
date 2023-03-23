//
//  MoviesDataTableViewCell.swift
//  MVVMProject
//
//  Created by Vartika on 21/01/21.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRatings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ data: Data) {
        if data.posterPath != nil {
            let posterURL = String(describing: data.posterPath!)
            let URL = "https://image.tmdb.org/t/p/w500\(posterURL)"
            AF.request(URL).responseImage { response in
                if case .success(let image) = response.result {
                    self.moviePoster.image = image
                } else {
                    self.moviePoster.image = #imageLiteral(resourceName: "imdb")
                }
            }
        }
        if data.title == nil || data.title == "" {
            self.movieName.text = data.name
        } else {
            self.movieName.text = data.title
        }
        self.movieRatings.text = String(data.voteAverage ?? 0)
    }
}
