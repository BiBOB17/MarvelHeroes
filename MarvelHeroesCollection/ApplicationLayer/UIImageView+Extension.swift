import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        HeroesImageService.shared.imageLoad(urlImage: url) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
