import UIKit
import Foundation

final class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let networkHeroesService = NetworkHeroesService.shared
    private let searchController = UISearchController(searchResultsController: nil)
     var allHeroes = [Heroes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.dataSource = self
        networkHeroesService.request() { (result) in
            switch result {
            case .success(let searchResponse):
                self.allHeroes = searchResponse.data.results
                print(self.allHeroes)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCollectionViewCell", for: indexPath) as! HeroesCollectionViewCell
        cell.configure(name: allHeroes[indexPath.row].name, imageURL: "0")
        return cell
    }
}

