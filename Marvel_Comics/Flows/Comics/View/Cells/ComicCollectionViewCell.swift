//
//  ComicCollectionViewCell.swift
//  Marvel_Comics
//
//  Created by Richardier on 22/03/2022.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let coverImageView = UIImageView()
    private let comicNameLabel = UILabel()
    private let parentStackView = UIStackView()
    
    static let identifier = "ComicCell"
    var comic: ComicResult? {
        didSet {
            refreshData()
        }
    }
    
    //MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshData()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func refreshData() {
        comicNameLabel.text = comic?.title
        let imagepath = "\(comic?.thumbnail.path ?? "")"+".\(comic?.thumbnail.thumbnailExtension ?? "")"
        if imagepath == "." {
            coverImageView.image = MCAImages.defaultComicImage
        } else {
            coverImageView.loadImage(imagepath)
        }
    }
    
    func setup() {
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 8
        parentStackView.addArrangedSubview(coverImageView)
        parentStackView.addArrangedSubview(comicNameLabel)
        
        addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            comicNameLabel.heightAnchor.constraint(equalToConstant: 30),
            parentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            parentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            parentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            parentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
