import UIKit

final class HeroesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var heroesImageView: UIImageView!
    
    func configure(name: String, imageURL: String) {
        heroesImageView.loadImage(from: imageURL)
        titleLabel.text = name
        setupUI()
    }
    
    private func setupUI() {
        heroesImageView.layer.cornerRadius = 8.0
        heroesImageView.clipsToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
    }
}

