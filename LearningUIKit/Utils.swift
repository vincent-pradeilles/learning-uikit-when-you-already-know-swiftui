//
//  Utils.swift
//  LearningUIKit
//
//  Created by Vincent on 04/03/2024.
//

import Foundation

let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()
