//
//  ComicDetailsViewController.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class ComicDetailsViewController: UIViewController {

    //MARK: - Properties
    
    var comic: ComicResult?
    
    var comicNameLabel = UILabel()
    var coverImageView = UIImageView()
    var descriptionTextView = UITextView()
    
    let parentStackView = UIStackView()
    
    //MARK: - View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    //MARK: - Methods

    
}

    //MARK: - View configuration

extension ComicDetailsViewController {
    
    func setupView() {
        comicNameLabel.textAlignment = .center
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 12
        parentStackView.addArrangedSubview(comicNameLabel)
        parentStackView.addArrangedSubview(coverImageView)
        parentStackView.addArrangedSubview(descriptionTextView)

        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            coverImageView.widthAnchor.constraint(equalToConstant: 220),
            coverImageView.heightAnchor.constraint(equalToConstant: 300),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 300),
            parentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupData() {
        comicNameLabel.text = comic?.title
        let imagepath = "\(comic?.thumbnail.path ?? "")"+".\(comic?.thumbnail.thumbnailExtension ?? "")"
        coverImageView.loadImage(imagepath)
        descriptionTextView.text = comic?.description
    }
}
