import UIKit
import Combine

class MainViewController: UIViewController {

    let testPosterView = PosterView()

    let tableView = UITableView()

    let searchResultsViewController: MainSearchResultsViewController
    let searchController: UISearchController

    private var cancellables: [AnyCancellable] = []

    var data: [MoviePoster] = []

    init() {
        searchResultsViewController = MainSearchResultsViewController()
        searchController = UISearchController(searchResultsController: searchResultsViewController)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        tableView.dataSource = self

        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        ImdbRepo.getMovieHotListPosters().sink { it in
            self.data = it
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = data[indexPath.item]

        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.rating

        return cell
    }
}
