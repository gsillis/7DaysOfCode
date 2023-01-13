import Foundation

enum MoviesEndpoint {
    case topRated
    case movieDetail(id: Int)
    case image(path: String)
}
 
extension MoviesEndpoint: Endpoint {    
    var path: String {
        switch self {
        case .topRated:
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .image(path: let path):
            return "https://image.tmdb.org/t/p/w500/\(path)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail, .image:
            return .get
        }
    }

    var header: [String: String] {
        //Replace with your access token
        guard let token = Bundle.main.infoDictionary?["API_TOKEN"] as? String else { return [:] }
        switch self {
        case .topRated, .movieDetail, .image:
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}

