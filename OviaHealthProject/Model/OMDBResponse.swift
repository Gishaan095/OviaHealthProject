//
//  OMDBResponse.swift
//  OviaHealthProject
//
//  Created by Ishaan Gupta 2 on 2/19/21.
//

import Foundation

struct OMDBResponse: Decodable {
  let Response: String
  let Error: String?
  let Title: String?
  let Poster: String?
  let imdbRating: String?
}
