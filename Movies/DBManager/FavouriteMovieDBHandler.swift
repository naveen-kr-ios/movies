//
//  FavouriteMovieDBHandler.swift
//  Movies
//
//  Created by Naveen Kumar V on 20/02/23.
//

import Foundation
import CoreData

class FavouriteMovieDBHandler {
    
    static let shared = FavouriteMovieDBHandler()
    private init(){
        loadFavourites()
    }
    private var favouriteMovies: [FavouriteMovies]?
    
    let context = AppDelegate().persistentContainer.viewContext
    
    // Add to favourites
    func addFavourite(_ movieID: Int) {
        do {
            let entity = FavouriteMovies(context: context)
            entity.movieID = Int32(movieID)
            entity.isFavourite = true
            try context.save()
            loadFavourites()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // Delete favourites
    func removeFavoutire(_ movieID: Int) {
        do {
            let request = FavouriteMovies.fetchRequest()
            request.predicate = NSPredicate(format: "movieID == %d", movieID)
            request.fetchLimit = 1
            if let movie = try context.fetch(request).first {
                context.delete(movie)
                try context.save()
            }
            loadFavourites()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // Load favourites
    private func loadFavourites() {
        let request = FavouriteMovies.fetchRequest()
        request.predicate = NSPredicate(format: "isFavourite == true")
        do {
            let result = try context.fetch(request)
            favouriteMovies = result
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // Validate whether the current movie is favourite
    func isFavourite(_ movieID: Int) -> Bool {
        guard let movie = favouriteMovies?.first(where: { $0.movieID == movieID})
        else {return false}
        return movie.isFavourite
    }
    
    func sample(helo: String) {
        
    }
}
