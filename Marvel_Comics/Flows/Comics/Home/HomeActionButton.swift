//
//  HomeActionButton.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class HomeActionButton: UIButton {
    
    func setup(title: String) {
        backgroundColor = MCAColor.marvelRed
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
        roundCorners(radius: 8)
    }
}
