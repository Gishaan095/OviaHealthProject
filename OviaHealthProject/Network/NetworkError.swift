//
//  NetworkError.swift
//  OviaHealthProject
//
//  Created by Ishaan Gupta 2 on 2/19/21.
//

import Foundation
enum NetworkError: LocalizedError {
  case stringToUrlFailed
  case invalidImageUrl
  case fetchingImageDataFailed
  
  var errorDescription: String? {
    switch self {
    case .stringToUrlFailed:
      return "Could not convert string to URL"
    case .invalidImageUrl:
      return "String Iimage URL could not be converted to URL"
    case .fetchingImageDataFailed:
      return "Could not fetch image data from URL."
    }
  }
}
