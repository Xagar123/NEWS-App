//
//  News.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import Foundation

struct News: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}

struct NewsEnvelope: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
