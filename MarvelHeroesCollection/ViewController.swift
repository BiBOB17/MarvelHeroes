
import UIKit
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class ViewController: UIViewController {
 let publickey = "de36ee4e20890765be860a8fa01f62af"
 let privatekey = "bd247574979a224154f58857d72c87ca038b092a"
 

    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        let ts = NSDate().timeIntervalSince1970
        let hashmd5 = Md5().getMd5(string: "\(ts)\(privatekey)\(publickey)")
        let hashValueHex = hashmd5.map {String(format: "%02hhx", $0) }.joined()
        let urlString = "https://gateway.marvel.com:443/v1/public/characters?orderBy=-modified&ts=\(ts)&apikey=\(publickey)&hash=\(hashValueHex)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                let someString = String(data: data, encoding: .utf8)
                print(someString ?? "o no")
            }
        }.resume()
    }
    
  

   
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        
    }
}

final class Md5 {
    
    func getMd5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
}
