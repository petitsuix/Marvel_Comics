//
//  ComicDetailsViewController.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

class ComicDetailsViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var comic: ComicResult?
    
    //MARK: - Private properties
    
    private let storageService = StorageService()
    private var isComicFavorite = false
    
    private let comicNameLabel = UILabel()
    private let coverImageView = UIImageView()
    private let descriptionTextView = UITextView()
    private let parentStackView = UIStackView()
    
    //MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteState()
        setupFavoriteButton()
    }
    
    //MARK: - @objc methods
    
    @objc
    func toggleFavorite() {
        if isComicFavorite == true {
            navigationItem.rightBarButtonItem?.image = MCAImages.heart
            removeFromFavorite()
            isComicFavorite = false
        } else {
            navigationItem.rightBarButtonItem?.image = MCAImages.heartFilled
            addToFavorite()
            isComicFavorite = true
        }
    }
    
    //MARK: - Methods
    
    private func fetchFavoriteState() {
        guard let comic = comic else { return }
        let comics = try? storageService.loadComics()
        guard let _ = comics?.first(where: { $0.id == comic.id }) else { isComicFavorite = false; return }
        isComicFavorite = true
    }
    
    private func addToFavorite() {
        guard let comic = comic else { return }
        do {
            try storageService.saveComic(comic)
            fetchFavoriteState()
        } catch {
            print(ServiceError.savingError)
            alert(Strings.wellWell, Strings.couldNotSave)
        }
    }
    
    private func removeFromFavorite() {
        guard let comic = comic else { return }
        do {
            try storageService.deleteComic(comic)
            isComicFavorite = false
        } catch {
            print(ServiceError.deletingError)
            alert(Strings.oops, Strings.couldNotDelete)
        }
    }
}

//MARK: - View configuration

extension ComicDetailsViewController {
    
    func setupView() {
        comicNameLabel.textAlignment = .center
        coverImageView.image = MCAImages.defaultComicImage
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 12
        parentStackView.addArrangedSubview(comicNameLabel)
        parentStackView.addArrangedSubview(coverImageView)
        parentStackView.addArrangedSubview(descriptionTextView)
        
        view.backgroundColor = .systemBackground
        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            coverImageView.widthAnchor.constraint(equalToConstant: 220),
            coverImageView.heightAnchor.constraint(equalToConstant: 300),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 300),
            parentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupFavoriteButton() {
        let navBarRightItem = UIBarButtonItem(
            image: UIImage(systemName: isComicFavorite ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = navBarRightItem
    }
    
    func setupData() {
        comicNameLabel.text = comic?.title
        let imagePath = "\(comic?.thumbnail.path ?? "")"+".\(comic?.thumbnail.thumbnailExtension ?? "")"
        coverImageView.loadImage(imagePath)
        descriptionTextView.text = comic?.description
    }
}
