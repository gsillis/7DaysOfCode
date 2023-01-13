protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var method: RequestMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var language: String { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.themoviedb.org"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var language: String {
        return "language=pt-BR"
    }
}
