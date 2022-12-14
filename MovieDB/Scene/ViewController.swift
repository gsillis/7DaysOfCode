//
//  ViewController.swift
//  MovieDB
//
//  Created by Gabriela Sillis on 14/12/22.
//

import UIKit

class ViewController: UIViewController {

    let service = ApiRequestService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlResult()
    }

    func getTopRated() async -> Result<TopRatedModel, NetworkError> {
        return await service.fetchMovies(endpoint: MoviesEndpoint.topRated, with: TopRatedModel.self)
    }
    
    func handlResult() {
        Task(priority: .background) {
            let result = await getTopRated()
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

