//
//  MainTableViewCell.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 14.03.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "myCell"
    
//MARK: - View
    
    var noteText: UILabel = {
            let label = UILabel()
            label.text = "text"
            label.numberOfLines = 2
    //        label.backgroundColor = .blue
        label.font = .systemFont(ofSize: 15, weight: .thin)
            return label
        } ()

    
    
//MARK: - Labels text
    func setup(note: Note) {
//        titleLabel.text = note.title
//        descriptionLabel.text = note.description
        noteText.text = note.tableText
        
    }
    
//MARK: - Required funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(descriptionLabel)
        contentView.addSubview(noteText)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Constraints Configuration
    func configureConstraints() {
        noteText.translatesAutoresizingMaskIntoConstraints = false
        noteText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        noteText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        noteText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        noteText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        noteText.heightAnchor.constraint(equalToConstant: 32).isActive = true
       
    }

}
