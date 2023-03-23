//
//  MovieListActions.swift
//  MVVMProject
//
//  Created by Vartika on 02/03/21.
//

import UIKit
import CoreData

class MovieListActions {
    enum Key:String {
        case id = "id"
        case video = "video"
        case voteCount = "voteCount"
        case voteAverage = "voteAverage"
        case title = "title"
        case name = "name"
        case releaseDate = "releaseDate"
        case originalLanguage = "originalLanguage"
        case originalTitle = "originalTitle"
        case firstAirDate = "firstAirDate"
        case adult = "adult"
        case overview = "overview"
        case posterPath = "posterPath"
        case popularity = "popularity"
        case mediaType = "mediaType"
        case backdropPath = "backdropPath"
        case originalName = "originalName"
    }
    
    func insertData(_ movieData: Data?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let newMovie = NSEntityDescription.insertNewObject(forEntityName: "FavMovies", into: context)
        newMovie.setValue(movieData?.id, forKey: Key.id.rawValue)
        newMovie.setValue(movieData?.video, forKey: Key.video.rawValue)
        newMovie.setValue(movieData?.voteCount, forKey: Key.voteCount.rawValue)
        newMovie.setValue(movieData?.voteAverage, forKey: Key.voteAverage.rawValue)
        newMovie.setValue(movieData?.title, forKey: Key.title.rawValue)
        newMovie.setValue(movieData?.name, forKey: Key.name.rawValue)
        newMovie.setValue(movieData?.releaseDate, forKey: Key.releaseDate.rawValue)
        newMovie.setValue(movieData?.originalLanguage, forKey: Key.originalLanguage.rawValue)
        newMovie.setValue(movieData?.originalTitle, forKey: Key.originalTitle.rawValue)
        newMovie.setValue(movieData?.backdropPath, forKey: Key.backdropPath.rawValue)
        newMovie.setValue(movieData?.originalName, forKey: Key.originalName.rawValue)
        newMovie.setValue(movieData?.firstAirDate, forKey: Key.firstAirDate.rawValue)
        newMovie.setValue(movieData?.adult, forKey: Key.adult.rawValue)
        newMovie.setValue(movieData?.overview, forKey: Key.overview.rawValue)
        newMovie.setValue(movieData?.posterPath, forKey: Key.posterPath.rawValue)
        newMovie.setValue(movieData?.popularity, forKey: Key.popularity.rawValue)
        newMovie.setValue(movieData?.mediaType, forKey: Key.mediaType.rawValue)
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func retrieveSavedMovies() -> [MovieData]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovies")
        request.returnsObjectsAsFaults = false
        var retrievedUsers: [MovieData] = []
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: Key.id.rawValue) as? Int else { return nil }
                    let video = result.value(forKey: Key.video.rawValue) as? Bool ?? false
                    guard let voteCount = result.value(forKey: Key.voteCount.rawValue) as? Int else { return nil }
                    guard let voteAverage = result.value(forKey: Key.voteAverage.rawValue) as? Float else { return nil }
                    let title = result.value(forKey: Key.title.rawValue) as? String ?? ""
                    let name = result.value(forKey: Key.name.rawValue) as? String ?? ""
                    let releaseDate = result.value(forKey: Key.releaseDate.rawValue) as? String ?? ""
                    let originalLanguage = result.value(forKey: Key.originalLanguage.rawValue) as? String ?? ""
                    let originalTitle = result.value(forKey: Key.originalTitle.rawValue) as? String ?? ""
                    let backdropPath = result.value(forKey: Key.backdropPath.rawValue) as? String ?? ""
                    let originalName = result.value(forKey: Key.originalName.rawValue) as? String ?? ""
                    let firstAirDate = result.value(forKey: Key.firstAirDate.rawValue) as? String ?? ""
                    let adult = result.value(forKey: Key.adult.rawValue) as? Bool ?? true
                    let overview = result.value(forKey: Key.overview.rawValue) as? String ?? ""
                    let posterPath = result.value(forKey: Key.posterPath.rawValue) as? String ?? ""
                    guard let popularity = result.value(forKey: Key.popularity.rawValue) as? Float else { return nil }
                    guard let mediaType = result.value(forKey: Key.mediaType.rawValue) as? String else { return nil }
                  let mov = MovieData(id: id, video: video, voteCount: voteCount, voteAverage: voteAverage, title: title, name: name, releaseDate: releaseDate, originalLanguage: originalLanguage, originalTitle: originalTitle, backdropPath: backdropPath, originalName: originalName, firstAirDate: firstAirDate, adult: adult, overview: overview, posterPath: posterPath, popularity: popularity, mediaType: mediaType)
                    retrievedUsers.append(mov)
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        return retrievedUsers
    }

    
    func checkIfAlreadyExists(_ favId: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true}
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovies")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "id") as? Int else { return true }
                    if id == favId {
                        return true
                    }
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        return false
    }
    
    func deleteFromList(_ favId: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovies")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "id") as? Int else { return }
                    if id == favId {
                        context.delete(result)
                    }
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
}
