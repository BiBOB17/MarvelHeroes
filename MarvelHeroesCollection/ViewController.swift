
import UIKit
import Foundation


class ViewController: UIViewController {
 let publickey = "de36ee4e20890765be860a8fa01f62af"
 let privatekey = "bd247574979a224154f58857d72c87ca038b092a"
 var allHeroes = [Heroes]()

    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        let ts = NSDate().timeIntervalSince1970
        let hashmd5 = Md5().getMd5(string: "\(ts)\(privatekey)\(publickey)")
        let hashValueHex = hashmd5.map {String(format: "%02hhx", $0) }.joined()
        let urlString = "https://gateway.marvel.com:443/v1/public/characters?orderBy=-modified&ts=\(ts)&apikey=\(publickey)&hash=\(hashValueHex)"
        request(urlString: urlString) { (result) in
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


func request(urlString: String, completion: @escaping (Result<HeroesResponse, Error>) -> Void) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let heroes = try JSONDecoder().decode(HeroesResponse.self, from: data)
                completion(.success(heroes))
            } catch let jsonError {
                print(jsonError)
                completion(.failure(jsonError ))
            }
        }
    }.resume()
}



