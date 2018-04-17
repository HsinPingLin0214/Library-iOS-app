//
//  Book+CoreDataProperties.swift
//  Library of Alexandria
//
//  Created by Jenna on 6/4/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var name: String?
    @NSManaged public var isbn: String?
    @NSManaged public var author: String?
    @NSManaged public var publisher: String?
    @NSManaged public var edition: String?
    @NSManaged public var year: Int64
    @NSManaged public var genre: String?
    @NSManaged public var desc: String?

}
