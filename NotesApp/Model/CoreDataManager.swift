//
//  CoreDataManager.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 21.03.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "NotesApp")
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(modelName: String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error while saving: \(error.localizedDescription)")
            }
        }
    }
}


extension CoreDataManager {
    
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = ""
        note.timeWhenLastChanged = Date()
        save()
        return note
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
    
    func fetchNotes() -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.timeWhenLastChanged, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return (try? viewContext.fetch(request)) ?? []
    }
}
