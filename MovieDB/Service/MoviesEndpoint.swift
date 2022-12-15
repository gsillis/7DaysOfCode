import Foundation

enum MoviesEndpoint {
    case topRated
    case movieDetail(id: Int)
}

extension MoviesEndpoint: Endpoint {    
    var path: String {
        switch self {
        case .topRated:
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail:
            return .get
        }
    }

    var header: [String: String] {
        //Replace with your access token
        guard let token = Bundle.main.infoDictionary?["API_TOKEN"] as? String else { return [:] }
        switch self {
        case .topRated, .movieDetail:
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}

