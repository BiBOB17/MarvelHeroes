import UIKit

final class FooterCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    func startSpinner() {
        spinner?.startAnimating()
    }
    
    func stopSpinner() {
        spinner?.stopAnimating()
    }
}
