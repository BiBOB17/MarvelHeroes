import UIKit

class HeroDetailViewController: UIViewController {
    @IBOutlet private weak var imageHero: UIImageView!
    @IBOutlet private weak var heroesName: UILabel!
    @IBOutlet private weak var descriptionHeroes: UILabel!
    var hero: Heroes?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hero = hero else { return }
        setupViewHeroes(hero: hero)
    }
    
    private func setupViewHeroes(hero: Heroes) {
        heroesName.text = hero.name
        descriptionHeroes.text = hero.description
        let imageUrl = hero.thumbnail.imageURL + "." + hero.thumbnail.imageType
        imageHero.loadImage(from: imageUrl)
    }
}
