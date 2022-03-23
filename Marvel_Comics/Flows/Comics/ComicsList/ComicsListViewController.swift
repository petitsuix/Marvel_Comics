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
            return "Tous les comics"
        case .coreData:
            return "Favoris"
        }
    }
}

enum State<Data> { // To execute particular actions according to the situation
    case loading
    case empty
    case error
    case showData(Data)
}

class ComicsListViewController: UIViewController {
    
    private enum Section {
        case main
    }
    
    private enum Item: Hashable {
        case comic(ComicResult, id: UUID = UUID())
    }

    //MARK: - Properties
    
    var storageService = StorageService()
    
    var dataMode: DataMode = .coreData
    var model: ComicsFlowModel?
    var networkService = NetworkService()
    var comics: [ComicResult] = []
    
    private var viewState: State<[ComicResult]> = .loading {
        didSet {
            resetState() // Hides tableview, stops activity indicator animation
            switch viewState {
            case .loading :
                activityIndicator.startAnimating()
                print("loading")
            case .empty :
                displayNoResultView()
                print("empty")
            case .error :
                // alert("Oops...", "Something went wrong, please try again.")
                print("error : fell into the .error case of viewState")
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
    
    //MARK: - @objc methods
    
    //MARK: - Methods
    
    private func resetState() {
        collectionView.isHidden = true
        activityIndicator.stopAnimating()
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
    
    func configureDataSource() {
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
    
    private func fetchComics() {
        viewState = .loading // Triggers activity indicator
        networkService.fetchData() { [weak self] result in // Calling data request. Completion expecting a result of type Result<success, failure>
            guard let self = self else { return }
            DispatchQueue.main.async { // Allows to modify UI from main thread
                switch result {
                case .success(let comicInfo) where comicInfo.data.results.isEmpty :
                    self.viewState = .empty
                case .success(let comicInfo):
                    self.viewState = .showData(comicInfo.data.results)
                case .failure(let error):
                    self.alert("Houston ?", "Something went wrong while trying to load comics. Perhaps you should give it another try ?")
                    print(error)
                }
            }
        }
    }
}

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
