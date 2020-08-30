import UIKit

class RatingStarView: UIView {

    let starImageView = UIImageView()
    let ratingLabel = UILabel()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        // MARK: Rating label
        ratingLabel.font = .systemFont(ofSize: 12)
        ratingLabel.textColor = .white

        addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        // MARK: Star image
        starImageView.image = UIImage.init(named: "Star")

        addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 4),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starImageView.topAnchor.constraint(equalTo: topAnchor),
            starImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor),
        ])

    }

    func update(rating: String) {
        ratingLabel.text = rating

        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: ratingLabel.intrinsicContentSize.height)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
