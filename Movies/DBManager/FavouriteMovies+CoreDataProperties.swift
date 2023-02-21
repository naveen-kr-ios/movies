//
//  FavouriteMovies+CoreDataProperties.swift
//  
//
//  Created by Naveen Kumar V on 20/02/23.
//
//

import Foundation
import CoreData


extension FavouriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovies> {
        return NSFetchRequest<FavouriteMovies>(entityName: "FavouriteMovies")
    }

    @NSManaged public var movieID: Int32
    @NSManaged public var isFavourite: Bool

}
