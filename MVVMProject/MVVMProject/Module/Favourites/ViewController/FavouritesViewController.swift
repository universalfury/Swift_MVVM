//
//  FavouritesViewController.swift
//  MVVMProject
//
//  Created by Vartika on 21/01/21.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var removeFromFavButton: UIButton!
    @IBOutlet weak var favMovieTableView: FavouriteMovieTableView!
    var moviesData: [MovieData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeFromFavButton.isHidden = true
        favMovieTableView.favController = self
        let nib = UINib.init(nibName: "MoviesDataTableViewCell", bundle: nil)
        favMovieTableView.register(nib, forCellReuseIdentifier: "movieInfoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "My Favourites"
        setUpData()
    }
    
    func setUpData() {
        moviesData = MovieListActions().retrieveSavedMovies()
//        print(moviesData)
        favMovieTableView.dataArray = moviesData
    }
}
