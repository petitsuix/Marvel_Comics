//
//  ViewController.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    let parentStackView = UIStackView()
    let logoImageView = UIImageView()
    let browseAllComicsButton = HomeActionButton()
    let favoriteComicsButton = HomeActionButton()

    //MARK: - View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - Methods

}


//MARK: - View configuration

extension HomeViewController {
    
    func setupView() {
        logoImageView.image = MCAImages.marvelLogo
        logoImageView.contentMode = .scaleAspectFit
        
        browseAllComicsButton.setup()
        browseAllComicsButton.setTitle(Strings.allComics, for: .normal)
        
        favoriteComicsButton.setup()
        favoriteComicsButton.setTitle(Strings.favoriteComics, for: .normal)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.distribution = .fillProportionally
        parentStackView.spacing = 16
        parentStackView.addArrangedSubview(logoImageView)
        parentStackView.addArrangedSubview(browseAllComicsButton)
        parentStackView.addArrangedSubview(favoriteComicsButton)
        
        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

