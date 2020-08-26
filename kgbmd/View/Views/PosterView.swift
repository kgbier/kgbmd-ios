import UIKit

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
