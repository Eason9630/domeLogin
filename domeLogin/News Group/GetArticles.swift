//
//  GetArticles.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/1.
//

import Foundation

class GetArticles {
    static let share = GetArticles()
    
    func getArt(completion: @escaping(Result<[Articles], Error>) -> Void){
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ad5c5f7946134e9a98087eba7ccaf28a"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let articServer = try JSONDecoder().decode(News.self, from: data)
                    print(articServer.articles.count)
                    completion(.success(articServer.articles))
                }catch{
                    completion(.failure(error))
                    print(error)
                }
                
                }
            }.resume()
        }
    }

