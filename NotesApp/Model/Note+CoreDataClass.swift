//
//  Note+CoreDataClass.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    var tableText: String {
        return "\(timeWhenLastChanged.format()) \(text ?? "")" // return second line
    }
}
