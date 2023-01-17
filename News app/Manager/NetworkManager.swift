//
//  NetworkManager.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import Foundation

class NetworkManager {
    
    //we are creating backup for images using NSCache
    let imageCache = NSCache<NSString, NSData>()
    
    //creating singleton
    static let shared = NetworkManager()
    
    private init() { }
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let TopHeadLine = "top-headlines?country=us&category=business"
    
    func getNews(completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseUrlString)\(TopHeadLine)&apiKey=\(Constant.API_KEY)"
        guard let url = URL(string: urlString) else { return}
        
       let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data , error == nil else {
                completion(nil)
                return
            }
           
           do{
               let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
               newsEnvelope == nil ? completion(nil) : completion(newsEnvelope?.articles)
           }catch {
               print(error.localizedDescription)
           }
        }
        task.resume()
    }
    
    func getImage(urlString: String, completion:@escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
            
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
            
        }else {
          let task =   URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data , error == nil else {
                    return
                }
                
                //storing the image in cashe as a backup
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }
            task.resume()
        }
        
    }
}
