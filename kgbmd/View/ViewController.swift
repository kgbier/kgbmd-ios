import UIKit
import Combine

class RootNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.prefersLargeTitles = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchResultsViewController: UIViewController {

}

class ViewController: UIViewController {

    let testPosterView = PosterView()

    let tableView = UITableView()

    let resultsTableViewController: SearchResultsViewController
    let searchController: UISearchController

    private var cancellables: [AnyCancellable] = []

    var data: [MoviePoster] = []

    init() {
        resultsTableViewController = SearchResultsViewController()
        searchController = UISearchController(searchResultsController: self.resultsTableViewController)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self

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

extension ViewController: UISearchControllerDelegate { }

extension ViewController: UISearchBarDelegate { }

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension ViewController : UITableViewDataSource {
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

class SubtitleTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PosterView: UIView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        backgroundColor = .secondarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
