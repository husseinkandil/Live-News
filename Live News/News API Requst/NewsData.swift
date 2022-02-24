//
//  NewsData.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit

protocol News {
    var imageURL: String? { get }
    var author: String? { get }
    var title: String? { get }
    var description: String? { get }
    var url: String? { get }
}

struct NewsData: Codable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
//    let image: String?
}

struct NewsResponse: Codable {
    var articles: [NewsData]
}

struct SportNewsResponse: Codable {
    var data: [SportData]
}

struct SportData: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let image: String?
}

extension NewsData: News {
    var imageURL: String? {
        urlToImage
    }
}

extension SportData: News {
    var imageURL: String? {
        image
    }
}

//"author"
//"title"
//"description"
//"url"
//"source"
//"image"
//"category
//"language"
//"country"
//"published_at"
