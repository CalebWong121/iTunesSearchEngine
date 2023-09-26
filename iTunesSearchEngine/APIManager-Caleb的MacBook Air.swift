import Foundation

class APIManager {
    
    
    
    func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping (Result<T,APIError>) -> Void){
        guard let url = url else {
            completion(Result.failure(APIError.badURL))
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error as? URLError {
                print(error)
                completion(Result.failure(APIError.URLSession(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            } else if let data = data {
                do {
//                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    print(error)
                    completion(Result.failure(APIError.decoding(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    func getURL(term: String, entity: Entitytype, limit: Int? = nil, offset: Int? = nil) -> URL? {
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = [URLQueryItem(name: "term", value: term.filter({$0 != " "})),
                                  URLQueryItem(name: "entity", value: entity.rawValue)]
        
        if let limit = limit {
            components?.queryItems?.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        if let offset = offset {
            components?.queryItems?.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        
        return components?.url
    }
}

enum FetchStatus: Equatable {
    case normal
    case loading
    case error(String)
}

enum Entitytype: String {
    case album, song
}
