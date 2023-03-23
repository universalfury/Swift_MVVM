//
//  MoviesHomeViewModel.swift
//  MVVMProject
//
//  Created by Vartika on 21/01/21.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

protocol MoviesHomeViewModelDelegate: class {
    func dataSuccesfullyRecieved()
    func showErrorView()
}

class MoviesHomeViewModel {
    var apiError: Bool = true
    var moviesData: [Data]?
    var widgetData = [Data]()
    var moviesModel: Trending? {
        didSet {
            moviesData = moviesModel?.results
        }
    }
    weak var delegate: MoviesHomeViewModelDelegate?
    
    func getDataForTrending() {
        AF.request("https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData {
                [weak self] response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    self?.apiError = true
                    self?.delegate?.showErrorView()
                case .success(let data):
                    do {
                        self?.apiError = false
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode(Trending.self, from: data)
                        self!.moviesModel = result
                        self?.delegate?.dataSuccesfullyRecieved()
                    } catch { self?.delegate?.showErrorView() }
                }
            }
    }
    
    func getDataForWidget() {
        AF.request("https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData {
                [weak self] response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self?.apiError = false
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode(Trending.self, from: data)
                        self!.moviesModel = result
                    } catch {  }
                }
            }
        widgetDataModelSetup()
    }
    
    private func widgetDataModelSetup() {
        for i in 0...3 {
            if moviesData?[i] != nil {
                widgetData.append(moviesData?[i] ?? Data())
            }
        }
    }
}

class Helper {
    class func getImage(imgURL: String?) -> UIImage {
        var movieImage: UIImage = UIImage()
        if imgURL != nil {
            let posterURL = String(describing: imgURL!)
            let URL = "https://image.tmdb.org/t/p/w500\(posterURL)"
            AF.request(URL).responseImage { response in
                if case .success(let image) = response.result {
                    movieImage = image
                    
                } else {
                    movieImage = UIImage(imageLiteralResourceName: "imdb")
                }
            }
        }
        return movieImage
    }
}
