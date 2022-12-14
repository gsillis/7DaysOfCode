import Foundation

protocol ApiRequestServing {
    func fetchMovies<T: Decodable>(endpoint: Endpoint, with model: T.Type) async -> Result<T, NetworkError>
}

final class ApiRequestService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension ApiRequestService: ApiRequestServing {
    func fetchMovies<T>(endpoint: Endpoint,  with model: T.Type) async -> Result<T, NetworkError> where T : Decodable {
        let urlComponents = configUrlComponents(with: endpoint)
        
        guard let url = urlComponents.url else {
            return .failure(.invalidUrl)
        }
        
        let request = configURLRequest(url: url, with: endpoint)
        let result = await handleRequestResult(request: request, with: model)
        return result
    }
}

private extension ApiRequestService {
    func configUrlComponents(with endpoint: Endpoint) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.baseURL
        urlComponents.path = endpoint.path
        return urlComponents
    }
    
    func configURLRequest(url: URL, with endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        return request
    }
    
    func handleRequestResult<T: Decodable>(request: URLRequest, with model: T.Type) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(model, from: data) else {
                    return .failure(.failureToDecodeJson)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedError)
            }
        } catch {
            return .failure(.unexpectedError)
        }
    }
}
