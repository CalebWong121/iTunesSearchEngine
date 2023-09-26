import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case URLSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "badURL"
        case .URLSession(let error):
            return "URLSession error: \(error.debugDescription)"
        case .badResponse(let statusCode):
            return "bad response with status code: \(statusCode)"
        case .decoding(let error):
            return "decoding error: \(error.debugDescription)"
        case .unknown:
            return "unknown error"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .badURL, .unknown:
            return "unknown error"
        case .URLSession(let error):
            return error?.localizedDescription ?? "unknown error"
        case .badResponse(_):
            return "unknown error"
        case .decoding(let decodingError):
            return decodingError?.localizedDescription ?? "unknown error"
        }
    }
}
