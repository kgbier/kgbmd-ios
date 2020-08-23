import UIKit

class RootNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.prefersLargeTitles = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    let testPosterView = PosterView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        navigationItem.title = "Hot films"

        view.addSubview(testPosterView)

        testPosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testPosterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testPosterView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testPosterView.widthAnchor.constraint(equalToConstant: 96),
            testPosterView.heightAnchor.constraint(equalToConstant: 128)
        ])

        _ = ImdbRepo.getMovieHotListPosters().sink { (it) in
            print(it)
        }
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
