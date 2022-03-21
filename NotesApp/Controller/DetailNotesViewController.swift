//
//  DetailNotesViewController.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 14.03.2022.
//

import UIKit

class DetailNotesViewController: UIViewController {
    
    var note: Note!
    weak var delegate: Delegate?
    

//MARK: - View
    private let notesTextField: UITextView = {
        let textField = UITextView()
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15, weight: .semibold)
        return textField
    }()

//MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextField.text = note?.text
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveNote))
        
//        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        view.addSubview(notesTextField)
        configureConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = self.navigationController?.navigationBar
        navBar?.tintColor = UIColor.orange
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notesTextField.becomeFirstResponder()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//MARK: - Methods
    @objc func saveNote() {
        self.note?.text = notesTextField.text
        if note?.text.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateNote() {
        print("Updating note")
        note.timeWhenLastChanged = Date()
        CoreDataManager.shared.save()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        print("Deleting note")
        delegate?.deleteNote(with: note.id)
        CoreDataManager.shared.deleteNote(note)

    }
    
    
//MARK: - Constraints
    func configureConstraints() {
        notesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
        notesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26).isActive = true
        notesTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notesTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        
    }
}

