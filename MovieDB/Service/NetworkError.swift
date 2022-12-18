enum NetworkError: Error, Equatable {
    case notFound
    case noData
    case badRequest
    case noResponse
    case invalidUrl
    case custom(error: String)
    case unauthorized
    case unexpectedError
    case failureToDecodeJson
}
