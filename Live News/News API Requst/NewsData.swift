//
//  NewsData.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit

struct NewsData: Codable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
}

struct NewsResponse: Codable {
    var articles: [NewsData]
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
