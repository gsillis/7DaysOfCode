import Foundation

enum MoviesEndpoint {
    case topRated
    case movieDetail(id: Int)
    case images(path: String)
}

extension MoviesEndpoint: Endpoint {
    var baseURL: String {
        switch self {
        case .images:
            return "image.tmdb.org"
        default:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .topRated:
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .images(let path):
            return "/t/p/original/\(path)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail, .images:
            return .get
        }
    }

    var header: [String: String] {
        //Replace with your access token
        guard let token = Bundle.main.infoDictionary?["API_TOKEN"] as? String else { return [:] }
        switch self {
        case .topRated, .movieDetail, .images:
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}

