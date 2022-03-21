//
//  Coordinator.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

protocol Coordinator {
    
    func start()
    var navigationController: UINavigationController { get set }
    
}
