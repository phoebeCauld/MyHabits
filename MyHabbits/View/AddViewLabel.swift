//
//  AddViewLabel.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 31.10.2021.
//

import UIKit

class AddViewLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String){
        super.init(frame: .zero)
        text = title
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
