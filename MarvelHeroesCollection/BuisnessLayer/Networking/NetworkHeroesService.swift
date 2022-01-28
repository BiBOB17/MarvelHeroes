import Foundation

final class NetworkHeroesService {
    
    static var shared = NetworkHeroesService()
   
    private init() {}
    
    func request(offset: Int, completion: @escaping (Result<HeroesResponse, Error>) -> Void) {
        let ts = NSDate().timeIntervalSince1970
        let hashmd5 = Md5().getMd5(string: "\(ts)\(AppConstans.privateKey)\(AppConstans.publicKey)")
        let hashValueHex = hashmd5.map {String(format: "%02hhx", $0) }.joined()
        let urlString = "\(AppConstans.urlString)?orderBy=-name&offset=\(String(offset))&ts=\(ts)&apikey=\(AppConstans.publicKey)&hash=\(hashValueHex)"
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
}
