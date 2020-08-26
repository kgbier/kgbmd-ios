import UIKit
import Combine

class MainSearchResultsViewController: UIViewController {

    let tableView = UITableView()

    private var cancellables: [AnyCancellable] = []

    var data: [String] = []

    override func viewDidLoad() {

        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }

}

extension MainSearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.count > 0 else { return }

        ImdbRepo.getSearchResults(for: query).sink { it in
            self.data = it
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
}

extension MainSearchResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = data[indexPath.item]

        cell.textLabel?.text = item

        return cell
    }
}
