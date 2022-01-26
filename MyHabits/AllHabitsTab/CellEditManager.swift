//
//  CellEditManager.swift
//  MyHabits
//
//  Created by F1xTeoNtTsS on 25.01.2022.
//

import Foundation
import UIKit

class CellEditManager {

    func transformCellFor(_ state: UIGestureRecognizer.State, and cell: UICollectionViewCell) {
        var transform: CGAffineTransform = .identity
        if state == .began {
            transform = .init(scaleX: 0.9, y: 0.9)
        } else if state == .ended {
            transform = .identity
        }
        UIView.animate(withDuration: 0.5, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) {
            cell.transform = transform
        }
    }
}
