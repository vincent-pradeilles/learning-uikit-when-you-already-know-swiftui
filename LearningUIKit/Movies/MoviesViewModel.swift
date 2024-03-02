//
//  MoviesViewModel.swift
//  LearningUIKit
//
//  Created by Vincent on 02/03/2024.
//

import Foundation

class MoviesViewModel {
    let movies: Variable<[Movie]> = Variable([])
    let error: Variable<Error?> = Variable(nil)

    private let service = MoviesService()

    func fetchData() {
        service.getMovies { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.movies.value = movieResponse.results
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
