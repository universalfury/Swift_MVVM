//
//  MoviesHomeViewController.swift
//  MVVMProject
//
//  Created by Vartika on 21/01/21.
//

import UIKit

class MoviesHomeViewController: UIViewController {

    @IBOutlet weak var moviesTableView: MovieInfoTableView!
    var moviesData = MoviesHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesData.delegate = self
        moviesTableView.controller = self
        let nib = UINib.init(nibName: "MoviesDataTableViewCell", bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: "movieInfoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Movies"
        moviesData.getDataForTrending()
    }
}

extension MoviesHomeViewController: MoviesHomeViewModelDelegate, ErrorViewDelegate {
    func tryAgainCallBack() {
        moviesData.getDataForTrending()
    }
    
    func dataSuccesfullyRecieved() {
        if let subview = self.view.viewWithTag(200) {
            subview.removeFromSuperview()
        }
        self.moviesTableView.isHidden = false
        moviesTableView.dataArray = moviesData.moviesData
    }
    
    func showErrorView() {
        print("Error")
        let errorView = ErrorView.fromNib() as ErrorView
        errorView.tag = 200
        errorView.apiErrorView.layer.cornerRadius = 5
        errorView.delegate = self
        errorView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.moviesTableView.isHidden = true
        self.view.addSubview(errorView)
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: T.self, options: nil)![0] as! T
    }
}
