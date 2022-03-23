//
//  ComicsListViewController.swift
//  Marvel_Comics
//
//  Created by Richardier on 21/03/2022.
//

import UIKit

enum DataMode {
    case api
    case coreData
    var title: String {
        switch self {
        case .api:
            return Strings.allComics
        case .coreData:
            return Strings.favoriteComics
        }
    }
}

enum State<Data> {
    case loading
    case empty
    case error
    case showData(Data)
}

class ComicsListViewController: UIViewController {
    
    //MARK: - Enums
    
    private enum Section {
        case main
    }
    
    private enum Item: Hashable {
        case comic(ComicResult, id: UUID = UUID())
    }

    //MARK: - Internal properties
    
    var dataMode: DataMode = .coreData
    var model: ComicsFlowModel?
    
    //MARK: - Private properties
    
    private let storageService = StorageService()
    private let networkService = NetworkService()
    private var comics: [ComicResult] = []
    private var viewState: State<[ComicResult]> = .loading {
        didSet {
            resetState()
            switch viewState {
            case .loading :
                activityIndicator.startAnimating()
            case .empty :
                displayNoResultView()
            case .error :
                alert(Strings.oops, Strings.somethingWentWrong)
            case .showData(let comics) :
                self.comics = comics
                collectionView.isHidden = false
                let snapshot = createComicsSnapshot(array: comics)
                diffableDataSource.apply(snapshot)
            }
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var collectionView: UICollectionView!
    
    //MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchComicsFromApi()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchComicsFromDatabase()
    }
    
    //MARK: - Methods
    
    private func resetState() {
        collectionView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .comic(let result, _):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.comicCellIdentifier, for: indexPath) as? ComicCollectionViewCell
                cell?.comic = result
                return cell
            }
        })
        let snapshot = createComicsSnapshot(array: comics)
        diffableDataSource.apply(snapshot)
    }
    
    private func createComicsSnapshot(array: [ComicResult]) -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([Section.main])
        let items = array.map { value in
            Item.comic(value)
        }
        snapshot.appendItems(items, toSection: .main)
        return snapshot
    }
    
    private func fetchComicsFromDatabase() {
        if dataMode == .coreData {
            do {
                comics = try storageService.loadComics()
                if comics.isEmpty {
                    viewState = .empty
                } else {
                    viewState = .showData(comics)
                }
            } catch { print("erreur : \(error)"); alert(Strings.couldNotLoadData, Strings.somethingWentWrong)}
        }
    }
    
    private func fetchComicsFromApi() {
        if dataMode == .api {
            fetchComics()
        }
    }
    
    private func fetchComics() {
        viewState = .loading
        networkService.fetchData() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comicInfo) where comicInfo.data.results.isEmpty :
                    self.viewState = .empty
                case .success(let comicInfo):
                    self.viewState = .showData(comicInfo.data.results)
                case .failure(let error):
                    self.alert(Strings.houston, Strings.somethingWentWrong)
                    print(error)
                }
            }
        }
    }
}

//MARK: - CollectionView configuration

extension ComicsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        model?.showComicDetailsScreen(comic: comics[indexPath.row])
    }
}

//MARK: - View configuration
extension ComicsListViewController {
    
    enum Constant {
        static let comicCellIdentifier = "ComicCell"
    }
    
    func setupView() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let comicsLayout = UICollectionViewFlowLayout()
        comicsLayout.scrollDirection = .vertical
        comicsLayout.itemSize = CGSize(width: view.frame.size.width/2.5, height: view.frame.size.width/1.7)
        comicsLayout.minimumLineSpacing = 32
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: comicsLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: ComicCollectionViewCell.identifier)
        
        title = dataMode.title
        view.backgroundColor = .systemBackground
        view.addSubview(activityIndicator)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func displayNoResultView() {
        let noResultTextView = UITextView.init(frame: self.view.frame)
        noResultTextView.text = Strings.nothingToShowHere
        noResultTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        noResultTextView.textAlignment = .center
        noResultTextView.isEditable = false
        noResultTextView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(noResultTextView, at: 0)
    }
}
