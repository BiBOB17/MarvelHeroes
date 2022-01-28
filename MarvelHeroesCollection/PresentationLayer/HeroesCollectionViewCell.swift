import UIKit

final class HeroesCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        static let cornerRadius: CGFloat = 8
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var heroesImageView: UIImageView!
    
    func configure(name: String, imageURL: String) {
        heroesImageView.loadImage(from: imageURL)
        titleLabel.text = name
        setupUI()
    }
    
    private func setupUI() {
        heroesImageView.layer.cornerRadius = Constants.cornerRadius
        heroesImageView.clipsToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = Constants.cornerRadius
        
    }
}

