import Foundation
import UIKit

final class HeroesImageService {
    
    static var shared = HeroesImageService()
    
    private init() {}
    
    func imageLoad(urlImage: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let imageURL = URL(string: urlImage) else { return }
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            completion(.success(image))
        }.resume()
    }
}
