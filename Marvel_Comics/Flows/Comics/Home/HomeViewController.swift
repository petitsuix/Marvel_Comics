//
//  ViewController.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    var model: ComicsFlowModel?
    
    let parentStackView = UIStackView()
    let logoImageView = UIImageView()
    let browseAllComicsButton = HomeActionButton()
    let favoriteComicsButton = HomeActionButton()

    //MARK: - View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @objc methods
    
    @objc
    func showAllComicsScreen() {
        model?.showAllComicsScreen()
    }
    
    @objc
    func showFavoriteComicsScreen() {
        model?.showFavoriteComicsScreen()
    }

    //MARK: - Methods

}


//MARK: - View configuration

extension HomeViewController {
    
    func setupView() {
        logoImageView.image = MCAImages.marvelLogo
        logoImageView.contentMode = .scaleAspectFit
        
        browseAllComicsButton.setup(title: Strings.allComics)
        browseAllComicsButton.addTarget(self, action: #selector(showAllComicsScreen), for: .touchUpInside)
        
        favoriteComicsButton.setup(title: Strings.favoriteComics)
        favoriteComicsButton.addTarget(self, action: #selector(showFavoriteComicsScreen), for: .touchUpInside)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.distribution = .fillProportionally
        parentStackView.spacing = 16
        parentStackView.addArrangedSubview(logoImageView)
        parentStackView.addArrangedSubview(browseAllComicsButton)
        parentStackView.addArrangedSubview(favoriteComicsButton)
        
        view.backgroundColor = .systemBackground
        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            parentStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            parentStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

