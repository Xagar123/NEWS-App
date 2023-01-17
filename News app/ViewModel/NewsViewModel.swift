//
//  NewsViewModel.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import Foundation

struct NewsViewModel {
    
    let news: News
    
    var author: String { //this are the  wraper object
        return news.author ?? "Unknown"
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var description: String  {
        return news.description ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "" // todo
    }
}
