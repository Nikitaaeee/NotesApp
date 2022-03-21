//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 20.03.2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var text: String!
    @NSManaged public var timeWhenLastChanged: Date!

}

extension Note : Identifiable {

}
