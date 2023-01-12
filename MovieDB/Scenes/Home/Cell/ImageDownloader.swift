import UIKit

protocol ImageDownloading {
    func image(from endpoint: Endpoint) async -> UIImage?
}

actor ImageDownloader {
    private enum CacheEntry {
        case inProgress(Task<Result<Data, NetworkError>, any Error>)
        case ready(UIImage)
    }
    
    private let service: ApiRequestServing
    private var cache: [String: CacheEntry] = [:]

    init(service: ApiRequestServing = ApiRequestService()) {
        self.service = service
    }
}

extension ImageDownloader: ImageDownloading {
    func image(from endpoint: Endpoint) async -> UIImage? {
        if let cached = cache[endpoint.baseURL] {
            switch cached {
            case .ready(let image):
                return image
            case .inProgress(let handle):
                switch try? await handle.value {
                case .success(let data):
                    if let data = UIImage(data: data) {
                        return data
                    }
                default: break
                }
            }
        }
        
        let handle = Task {
            try await service.downloadImage(endpoint: endpoint)
        }
        
        cache[endpoint.baseURL] = .inProgress(handle)
        let image = try? await handle.value
        guard case .success = image else { return  UIImage() }
        cache[endpoint.baseURL] = .ready(downloadedImage ?? UIImage())
         return downloadedImage
    }
}
