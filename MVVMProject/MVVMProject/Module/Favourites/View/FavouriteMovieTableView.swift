//
//  FavouriteMovieTableView.swift
//  MVVMProject
//
//  Created by Vartika on 02/03/21.
//

import UIKit

class FavouriteMovieTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var favController: FavouritesViewController?
    
    
    var dataArray: [MovieData]? {
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
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureRecognized(_:)))
        self.addGestureRecognizer(longpress)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let datacount = dataArray?.count ?? 0
        let isFav = dataArray?[indexPath.row].isFavourite ?? true
        if datacount > 0 && isFav {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfoCell", for: indexPath) as! MoviesDataTableViewCell
            cell.configCell((dataArray?[indexPath.row])!.movie)
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
        vc.movieInfo = dataArray?[indexPath.row].movie
        favController?.navigationController!.pushViewController(vc, animated: true)
    }
    
    @objc func longPressGestureRecognized(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let longPress = gestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: self)
        let indexPath = self.indexPathForRow(at: locationInView)
        
        struct My {
            static var cellSnapshot : UIView? = nil
        }
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        
        switch state {
        case .began:
            if indexPath != nil {
                favController?.removeFromFavButton.isHidden = false
                favController?.removeFromFavButton.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                Path.initialIndexPath = indexPath
                let cell = self.cellForRow(at: indexPath!) as UITableViewCell?
                My.cellSnapshot  = snapshopOfCell(inputView: cell!)
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                self.addSubview(My.cellSnapshot!)
                self.bringSubviewToFront(My.cellSnapshot!)
                My.cellSnapshot?.layer.zPosition = 1
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform.identity.scaledBy(x: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                    
                }, completion: { (finished) -> Void in
                    if finished {
                        cell?.isHidden = true
                    }
                })
            }
            
        case .changed:
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            FavouriteMovieTableView.startAnimatingView(on: My.cellSnapshot!)
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                self.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                Path.initialIndexPath = indexPath
            }
            let temp = (favController?.removeFromFavButton.center.y)! - center.y
            if (temp <= 120 && temp >= -120) {
                
                favController?.removeFromFavButton.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
            } else {
                favController?.removeFromFavButton.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }
            
        case .ended:
            favController?.removeFromFavButton.isHidden = true
            let center = My.cellSnapshot!.center
            let cell = self.cellForRow(at: Path.initialIndexPath! as IndexPath) as UITableViewCell?
            self.layer.opacity = 1
            cell?.isHidden = false
            cell?.alpha = 0.0
            let temp = (favController?.removeFromFavButton.center.y)! - center.y
            if (temp <= 120 && temp >= -120) {
                favController?.removeFromFavButton.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
                deleteAMovie(Path.initialIndexPath?.row ?? -1, Path.initialIndexPath!)
                print("Trying To delete")
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = cell!.center
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
                })
                dataArray = MovieListActions().retrieveSavedMovies()
                self.reloadData()
            } else {
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = cell!.center
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
                })
            }
        default:
            self.reloadData()
        }
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    static func startAnimatingView(on onView: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = NSNumber(value: -0.0349066)
        animation.toValue = NSNumber(value: 0.0349066)
        animation.duration = 0.07
        animation.isCumulative = false
        animation.repeatCount = 4
        onView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    func deleteAMovie(_ atIndex: Int, _ indexPath: IndexPath) {
        let forId = dataArray?[atIndex].movie.id ?? -1
        let alert = UIAlertController(title: "Delete the Movie", message: "Are you sure you want to delete the movie from your favourites?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            MovieListActions().deleteFromList(forId)
            self.dataArray?[atIndex].isFavourite = false
            self.reloadData()
//            self.cellForRow(at: indexPath)?.isHidden = true
            //            flag = true
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
            //            flag = false
        }))
        favController?.present(alert, animated: true, completion: nil)
    }
}

