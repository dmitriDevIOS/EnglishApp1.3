//
//  NetworkService.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation


class NetworkService {
    
    static let shared = NetworkService()
    
    let headers = [
        "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
        "x-rapidapi-key": "b04420b288msh642f99928f6514cp1ce02bjsn429c5eef3e9f"
    ]
    
    
    func fetchSearchedWords(searchWord: String, completionHandler: @escaping(Word) ->()) {
        
        guard let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(searchWord)") else { return }
        
        let request = NSMutableURLRequest(url: url ,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
        if let data = data {
                do {
                    let word = try JSONDecoder().decode(Word.self, from: data)
                    completionHandler(word)
                } catch let error {
                    print(error.localizedDescription)
                    let word = Word(word: "wrong word")
                    completionHandler(word)
                }
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }.resume()
    }
    
    
    
    
    
}







