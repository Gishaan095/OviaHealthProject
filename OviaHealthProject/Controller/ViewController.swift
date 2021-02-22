//
//  ViewController.swift
//  OviaHealthProject
//
//  Created by Ishaan Gupta 2 on 2/18/21.
//

import UIKit
import Cosmos
import JGProgressHUD

class ViewController: UIViewController {
  
  @IBOutlet weak var movieNameLabel: UILabel!
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var cosmosView: CosmosView!
  @IBOutlet var searchBar: UISearchBar!
  let networkManager = NetworkManager()
  let hud = JGProgressHUD(style: .dark)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    networkManager.delegate = self
    searchBar.placeholder = "Search for movies"
    searchBar.delegate = self
    searchBar.showsCancelButton = true
    navigationItem.titleView = searchBar
  }
  
  func convertIMBDRating(rating: Double) -> Double {
    let x = rating/10 * 5
    return Double(round(x*10)/10)
  }
}

extension ViewController: NetworkManagerDelegate {
  
  func didGetResponse(networkManager: NetworkManager, response: OMDBResponse) {
    DispatchQueue.main.async {
      self.hud.dismiss(animated: true)
    }
    if response.Response == "True" {
      DispatchQueue.main.async {
        self.movieNameLabel.text = response.Title
        self.cosmosView.isHidden = false
        if let rating = Double(response.imdbRating!) {
          let reqValue = self.convertIMBDRating(rating: rating)
          self.cosmosView.rating = reqValue
          self.cosmosView.text = "\(reqValue)"
        }
      }
      networkManager.downloadImage(imageUrl: response.Poster!, completionHandler: { (error, image) in
        if let e = error {
          print("Error occured in fetching image\(e)")
          DispatchQueue.main.async {
            self.movieImage.image = UIImage(named: "imageNotFound")
          }
        } else {
          DispatchQueue.main.async {
            self.movieImage.image = image
          }
        }
      })
    } else {
      DispatchQueue.main.async {
        self.movieNameLabel.text = "Movie not found"
        self.cosmosView.isHidden = true
        self.movieImage.image = UIImage(named: "noImage")
      }
    }
  }
  
  func didFinishWithError(error: Error) {
    DispatchQueue.main.async {
      self.hud.dismiss(animated: true)
    }
    print(error)
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    DispatchQueue.main.async {
      self.hud.show(in: self.view, animated: true)
    }
    networkManager.fetchData(title: searchBar.text ?? "")
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

