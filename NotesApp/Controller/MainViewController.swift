//
//  MainViewController.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 14.03.2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    private var allNotes: [Note] = [] {
        didSet{
            notesCountLabel.text = "\(allNotes.count) \(allNotes.count == 1 ? "Note" : "Notes")"
        }
    }
        
//MARK: - View
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MainTableViewCell.self,
                           forCellReuseIdentifier: MainTableViewCell.identifier)
        return tableView
    }()
    
    private let notesCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0 Notes"
        label.backgroundColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotesFromStorage()
        
        if allNotes.count == 0 {
            makeInitialNote()
        }
   
        tableView.backgroundColor = .secondarySystemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        view.addSubview(notesCountLabel)
        
        configureConstraints()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "My Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(createNoteBtnPressed))
    }
    
//MARK: - Methods
    @objc func createNoteBtnPressed(){
        goToNote(createNote())
    }
    
    func createNote() -> Note {
        let note = CoreDataManager.shared.createNote()
        allNotes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        return note
    }
    
    func idForNote(id: UUID, list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    func goToNote(_ note: Note){
        let destVc = DetailNotesViewController()
        destVc.note = note
        destVc.delegate = self
        navigationController?.pushViewController(destVc, animated: true)
    }
    
    func fetchNotesFromStorage() {
        allNotes = CoreDataManager.shared.fetchNotes()
    }
    
    private func deleteNoteFromStorage(_ note: Note) {
        deleteNote(with: note.id)
        CoreDataManager.shared.deleteNote(note)
    }
    
    private func makeInitialNote() {
        let note = CoreDataManager.shared.createNote()
        note.text = "Hello!"
        allNotes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }

//MARK: - Constraints
    func configureConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -86).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        notesCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notesCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notesCountLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        notesCountLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        notesCountLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


//MARK: -  Table View Configuration
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return allNotes.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.setup(note: allNotes[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        goToNote(allNotes[indexPath.row])

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNoteFromStorage(allNotes[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

//MARK: - MainVC DELEGATE
extension MainViewController: Delegate {
    
    func refreshNotes() {
        allNotes = allNotes.sorted { $0.timeWhenLastChanged > $1.timeWhenLastChanged }
        tableView.reloadData()
    }
    
    func deleteNote(with id: UUID) {
        let indexPath = idForNote(id: id, list: allNotes)
        allNotes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
}


