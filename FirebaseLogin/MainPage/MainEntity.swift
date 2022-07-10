//
//  MainEntity.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation

struct MainEntity: Codable {
    let articles: [Article]?
}
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let url: String?
    let content: String?
    let articleDescription: String?
    let urlToImage: String?
    let publishedAt: String?
}
struct Source: Codable {
    let name: String?
}
