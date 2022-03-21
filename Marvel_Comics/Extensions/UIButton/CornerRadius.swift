//
//  CornerRadius.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

extension UIButton {
    func roundCorners(radius: Int) {
    self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
}
