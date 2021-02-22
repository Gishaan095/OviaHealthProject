//
//  NetworkManager.swift
//  OviaHealthProject
//
//  Created by Ishaan Gupta 2 on 2/19/21.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate: AnyObject {
  func didGetResponse(networkManager: NetworkManager, response: OMDBResponse)
  func didFinishWithError(error: Error)
}

class NetworkManager {
  weak var delegate: NetworkManagerDelegate?
  fileprivate let apiKey = "ee60b1cc"
  
  fileprivate func getUrl(title: String) -> URL? {
    let titleWithoutSpaces = title.replacingOccurrences(of: " ", with: "+")
    return title.isEmpty ? nil : URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&t=\(titleWithoutSpaces)")
  }
  
  func fetchData(title: String) {
    
    guard let url = getUrl(title: title) else {
      delegate?.didFinishWithError(error: NetworkError.stringToUrlFailed)
      return
    }
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: url) { (data, response, error) in
      if let e = error {
        self.delegate?.didFinishWithError(error: e)
        return
      }
      if let safeData = data {
        let jsonDecoder = JSONDecoder()
        do {
          let res = try jsonDecoder.decode(OMDBResponse.self, from: safeData)
          self.delegate?.didGetResponse(networkManager: self, response: res)
        } catch {
          self.delegate?.didFinishWithError(error: error)
        }
      }
    }
    dataTask.resume()
  }
  
  func downloadImage(imageUrl: String, completionHandler: @escaping (_ error: Error?, _ image: UIImage?) -> ()) {
    guard let url = URL(string: imageUrl) else {
      completionHandler(NetworkError.invalidImageUrl, nil)
      return
    }
    do {
      let imageData = try Data(contentsOf: url)
      if let image = UIImage(data: imageData) {
        completionHandler(nil, image)
      } else {
        completionHandler(NetworkError.fetchingImageDataFailed, nil)
      }
    } catch {
      completionHandler(error, nil)
    }
  }
}
