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
        name.numberOfLines = 3
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
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("...", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func settingsButtonTapped(_ sender: UIButton){
        let settingsView = SettingsView()
        settingsView.layer.cornerRadius = 10
        settingsView.clipsToBounds = true
        contentView.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 3),
            settingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            settingsView.widthAnchor.constraint(equalToConstant: 150),
            settingsView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
     
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
        contentView.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            settingsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -5),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
