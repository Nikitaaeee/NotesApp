//
//  Delegate.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 17.03.2022.
//

import Foundation

protocol MainViewDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}
