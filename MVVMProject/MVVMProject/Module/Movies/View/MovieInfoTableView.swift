//
//  MovieInfoTableView.swift
//  MVVMProject
//
//  Created by Vartika on 22/01/21.
//

import UIKit

class MovieInfoTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var fromHome: Bool = true
//    var favController: FavouritesViewController? {
//        didSet {
//            fromHome = false
//        }
//    }
    var controller: MoviesHomeViewController? {
        didSet {
            fromHome = true
        }
    }
    var dataArray: [Data]? {
        didSet {
            self.reloadData()
        }
    }
    init(frame: CGRect) {
        super.init(frame: frame, style: UITableView.Style.plain)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    func commonInit() {
        self.dataSource = self
        self.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let datacount = dataArray?.count ?? 0
        if datacount > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfoCell", for: indexPath) as! MoviesDataTableViewCell
            cell.configCell((dataArray?[indexPath.row])!)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let datacount = dataArray?.count ?? 0
        if datacount > 0 {
            return 100
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        vc.movieInfo = dataArray?[indexPath.row]
        if fromHome {
            controller?.navigationController!.pushViewController(vc, animated: true)
        }
//        } else {
//            favController?.navigationController!.pushViewController(vc, animated: true)
//        }
    }
}
