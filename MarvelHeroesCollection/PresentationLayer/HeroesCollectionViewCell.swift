import UIKit

final class HeroesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var heroesImageView: UIImageView!
    
    func configure(name: String, imageURL: String) {
        heroesImageView.loadImage(from: imageURL)
        titleLabel.text = name
    }
}

