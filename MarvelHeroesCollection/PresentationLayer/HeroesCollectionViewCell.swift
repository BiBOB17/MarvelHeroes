import UIKit

final class HeroesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var heroesImageView: UIImageView!
    
    func configure(name: String, imageURL: String) {
        titleLabel.text = name
    }
}

