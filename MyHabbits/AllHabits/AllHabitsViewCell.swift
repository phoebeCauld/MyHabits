//
//  AllHabitsViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 04.12.2021.
//

import UIKit

class AllHabitsViewCell: UICollectionViewCell {
    
    let habitName: UILabel = {
        let name = UILabel()
        name.font = .boldSystemFont(ofSize: 20)
        name.numberOfLines = 0
        name.text = "Name of HAbit"
        return name
    }()
    
    let daysLabel: UILabel = {
        let name = UILabel()
        name.text = "every mon, sat, sun"
        return name
    }()
    
    let calendarImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "calendar")
        iv.tintColor = .black
        iv.isHidden = true
        return iv
    }()
    
    
    let timeLabel: UILabel = {
        let name = UILabel()
        name.text = ""
        return name
    }()
    let clockImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "clock")
        iv.tintColor = .black
        iv.isHidden = true
        return iv
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        setConstraints()
    }
    
    func setConstraints(){
        let timeStack = UIStackView(arrangedSubviews: [clockImage,timeLabel])
        timeStack.spacing = 8
        let daysStack = UIStackView(arrangedSubviews: [calendarImage,daysLabel])
        daysStack.spacing = 8
        let stack = CellStack.addStack(with: [habitName,timeStack,daysStack], contentView)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
