import UIKit
import Combine

class PosterGridCollectionView: UICollectionView {

    var data: [MoviePoster] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 100, height: 148)
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        dataSource = self
        register(PosterViewCell.self, forCellWithReuseIdentifier: "poster")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PosterGridCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "poster", for: indexPath) as! PosterViewCell
        let poster = cell.posterView

        let item = data[indexPath.item]

        poster.update(rating: item.rating)
        poster.update(title: item.title)
        poster.update(imageUrl: item.posterUrlSmall, thumbnailUrl: item.thumbnailUrl)

        return cell
    }
}

class MainViewController: UIViewController {

    let testPosterView = PosterView()

    let posterGridView = PosterGridCollectionView()

    let searchResultsViewController: MainSearchResultsViewController
    let searchController: UISearchController

    private var cancellables: [AnyCancellable] = []

    var data: [MoviePoster] = []

    init() {
        searchResultsViewController = MainSearchResultsViewController()
        searchController = UISearchController(searchResultsController: searchResultsViewController)

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        searchController.searchResultsUpdater = searchResultsViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.autocapitalizationType = .none

        navigationItem.title = "Hot films"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        view.addSubview(posterGridView)

        posterGridView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterGridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            posterGridView.topAnchor.constraint(equalTo: view.topAnchor),
            posterGridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            posterGridView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        posterGridView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)

        ImdbRepo.getMovieHotListPosters().sink { it in
            self.posterGridView.data = it
            self.posterGridView.reloadData()
        }.store(in: &cancellables)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
