import UIKit
import Foundation

final class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let networkHeroesService = NetworkHeroesService.shared
    private let searchController = UISearchController(searchResultsController: nil)
    private var allHeroes = [Heroes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        networkHeroesService.request() { (result) in
            switch result {
            case .success(let searchResponse):
                self.allHeroes = searchResponse.data.results
                print(self.allHeroes)
            case .failure(let error):
                print(error)
            }
        }
    }
}





