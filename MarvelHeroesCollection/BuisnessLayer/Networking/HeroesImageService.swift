import Foundation
import UIKit

final class HeroesImageService {
    
    private let cache = NSCache<NSString, UIImage>()
    private var heroURL = String()
    static var shared = HeroesImageService()
    
    private init() {}
    
    func imageLoad(urlImage: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = cache.object(forKey: NSString(string: urlImage)) {
            completion(.success(cachedImage))
        } else {
            guard let imageURL = URL(string: urlImage) else { return }
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data, let image = UIImage(data: data) else { return }
                self.cache.setObject(image, forKey: NSString(string: urlImage))
                completion(.success(image))
            }.resume()
        }
    }
}
