//
//  MovieDetailsViewModel.swift
//  LearningUIKit
//
//  Created by Vincent on 04/03/2024.
//

import Foundation
import UIKit

class MovieDetailsViewModel {

    let movie: Movie

    let poster: Variable<UIImage?> = Variable(nil)
    let cast: Variable<[MovieCastMember]> = Variable([])

    private let service = MovieDetailsService()
    
    init(movie: Movie) {
        self.movie = movie
    }

    func fetchData() {
        service.getPoster(for: movie) { [weak self] result in
            switch result {
            case .success(let poster):
                self?.poster.value = poster
            case .failure:
                break
            }
        }

        service.getCredits(for: movie) { [weak self] result in
            switch result {
            case .success(let creditsResponse):
                self?.cast.value = creditsResponse.cast
            case .failure:
                break
            }
        }
    }
}
