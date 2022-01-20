import UIKit
import Foundation

final class ViewController: UIViewController {
    @IBOutlet private weak var heroesCollectionView: UICollectionView!
    
    private let networkHeroesService = NetworkHeroesService.shared
    private let searchController = UISearchController(searchResultsController: nil)
    var allHeroes = [Heroes]()
    var spinner = FooterCollectionReusableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroesCollectionView.delegate = self
        heroesCollectionView.dataSource = self
        loadData()
    }
    
    private func loadData() {
        networkHeroesService.request(offset: allHeroes.count) { (result) in
            switch result {
            case .success(let searchResponse):
                self.allHeroes.append(contentsOf: searchResponse.data.results)
                self.heroesCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
            self.spinner.stopSpinner()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = heroesCollectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: "footer", for: indexPath) as! FooterCollectionReusableView
            spinner = footer
            
            return footer
        }
        return UICollectionReusableView()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let thumbnail = allHeroes[indexPath.row].thumbnail
        let urlImage = thumbnail.imageURL + "." +  thumbnail.imageType
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCollectionViewCell", for: indexPath) as! HeroesCollectionViewCell
        cell.configure(name: allHeroes[indexPath.row].name, imageURL: urlImage)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(allHeroes[indexPath.row].name)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if allHeroes.count - 1 == indexPath.row {
            spinner.startSpinner()
            loadData()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width * 0.5) - 16
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
}


