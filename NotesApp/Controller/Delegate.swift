//
//  Delegate.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 18.03.2022.
//

import UIKit
protocol Delegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}
