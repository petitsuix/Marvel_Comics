//
//  HomeActionButton.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class HomeActionButton: UIButton {
    
    func setup() {
        backgroundColor = MCAColor.marvelRed
        setTitleColor(.white, for: .normal)
        roundCorners(radius: 8)
    }
}
