//
//  SectionCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.11.2021.
//

import UIKit

class SectionCell: UITableViewCell {

    let sectionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    let openImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.ImageLabels.openImage
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(_ view: UIView){
        let cellStack = UIStackView(arrangedSubviews: [sectionLabel, openImage])
        cellStack.alignment = .center
        cellStack.axis = .horizontal
        cellStack.distribution = .fill
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellStack)
        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            openImage.heightAnchor.constraint(equalToConstant: 25),
            openImage.widthAnchor.constraint(equalTo: openImage.heightAnchor)
            
        ])
    }
}
