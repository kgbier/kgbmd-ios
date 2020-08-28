import UIKit

class PosterView: UIView {

    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let ratingLabel = UILabel()

    let bottomScrimGradient = CAGradientLayer()
    let bottomScrim = UIView()

    let ratingLabelScrimGradient = CAGradientLayer()
    let ratingLabelScrim = UIView()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        // MARK: View
        layer.cornerRadius = 4
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true

        // MARK: Poster image
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // MARK: Title label
        addSubview(bottomScrim) // Add beneath

        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .white

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])

        // MARK: Rating label
        addSubview(ratingLabelScrim) // Add beneath

        ratingLabel.font = .systemFont(ofSize: 12)
        ratingLabel.textColor = .white

        addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
        ])

        // MARK: Scrim
        bottomScrim.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomScrim.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomScrim.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomScrim.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomScrim.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
        ])

        bottomScrimGradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]

        bottomScrimGradient.startPoint = CGPoint(x: 0, y: 1)
        bottomScrimGradient.endPoint = CGPoint(x: 0, y: 0)

        bottomScrim.layer.addSublayer(bottomScrimGradient)

        ratingLabelScrim.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabelScrim.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -24),
            ratingLabelScrim.topAnchor.constraint(equalTo: topAnchor),
            ratingLabelScrim.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingLabelScrim.heightAnchor.constraint(equalTo: ratingLabelScrim.widthAnchor)
        ])

        ratingLabelScrimGradient.colors = [
            UIColor.black.cgColor,
            CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 170),
            UIColor.clear.cgColor
        ]

        ratingLabelScrimGradient.type = .radial

        ratingLabelScrimGradient.startPoint = CGPoint(x: 1, y: -0.3)
        ratingLabelScrimGradient.endPoint = CGPoint(x: 0, y: 0.7)

        ratingLabelScrim.layer.addSublayer(ratingLabelScrimGradient)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        bottomScrimGradient.frame = bottomScrim.bounds
        ratingLabelScrimGradient.frame = ratingLabelScrim.bounds
    }


//    func update(imageUrl: String, thumbnailUrl: String) {
//    }

    func update(title: String) {
        titleLabel.text = title
    }

    func update(rating: String?) {
        guard let rating = rating else {
            ratingLabelScrim.isHidden = true
            return
        }

        ratingLabel.text = rating
        ratingLabelScrim.isHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PosterViewCell: UICollectionViewCell {

    let posterView = PosterView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(posterView)

        posterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterView.topAnchor.constraint(equalTo: topAnchor),
            posterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterView.widthAnchor.constraint(equalToConstant: 100),
            posterView.heightAnchor.constraint(equalToConstant: 148),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

