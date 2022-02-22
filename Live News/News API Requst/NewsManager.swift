//
//  NewsManager.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//23001ea48e4d43429cb9f1f551570e05

import UIKit

protocol NewsManagerDelegate: AnyObject {
    func didUpdateNews(_ newsManager: NewsManager, news: [NewsData])
    func didFailWithError(error: Error)
}

class NewsManager {
    let newsURL = URLs.liveNewsUrl
    let sportUrl = URLs.sportsURL
    
    weak var delegate: NewsManagerDelegate?
    
    func fetchNews() {
        performRequest(with: newsURL)
    }
    
    func fetchSportNews() {
        performRequest(with: sportUrl)
    }
    
    func performRequest(with URLString: String) {
        if let url = URL(string: URLString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let newsResponse = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateNews(self, news: newsResponse.articles)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ newsData: Data) -> NewsResponse? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsResponse.self, from: newsData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
