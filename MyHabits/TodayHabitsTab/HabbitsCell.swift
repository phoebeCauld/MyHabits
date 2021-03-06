//
//  HabbitsCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class HabbitsCell: UITableViewCell {

     let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

     let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView(contentView)
        setConstraints(contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView(_ view: UIView) {
        view.addSubview(cellView)
    }

    private func setConstraints(_ view: UIView) {
        let cellStack = UIStackView(arrangedSubviews: [title])
        cellStack.axis = .horizontal
        cellStack.alignment = .center
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellStack)

        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: ConstantsForConstraints.viewConst),
            cellView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: ConstantsForConstraints.viewConst),
            cellView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -(ConstantsForConstraints.viewConst)),
            cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -(ConstantsForConstraints.viewConst)),
            cellView.heightAnchor.constraint(equalToConstant: ConstantsForConstraints.cellHeight),

            cellStack.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,
                                               constant: ConstantsForConstraints.stackConst),
            cellStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,
                                               constant: -ConstantsForConstraints.stackConst),
            cellStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
    }
}

struct ConstantsForConstraints {
    static let viewConst: CGFloat = 5
    static let cellHeight: CGFloat = 100
    static let stackConst: CGFloat = 10
}
