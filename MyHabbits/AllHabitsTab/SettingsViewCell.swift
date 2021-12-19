//
//  SettingsViewCell.swift
//  MyHabits
//
//  Created by F1xTeoNtTsS on 19.12.2021.
//

import UIKit

class SettingsViewCell: UITableViewCell {
    
    var settingsOptions: SettingsOptions! {
        didSet {
            title.text = settingsOptions.title
            optionsIcon.image = settingsOptions.Image
        }
    }

    let title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20)
        return title
    }()
    
    let optionsIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    func setConstraints(){
        let stack = UIStackView(arrangedSubviews: [title, optionsIcon])
        stack.alignment = .center
//        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
