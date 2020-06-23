//
//  NetworkService.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit



class NetworkService {
    
    static let shared = NetworkService()
    
    
    // MARK: - WORDSAPI headers
    let WordsAPIHeaders = [
        "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
        "x-rapidapi-key": "b04420b288msh642f99928f6514cp1ce02bjsn429c5eef3e9f"
    ]
    
    //MARK: - Google translation headers

    let GoogleTranslateHeaders =  [
        "x-rapidapi-host": "google-translate1.p.rapidapi.com",
        "x-rapidapi-key": "cee6990283mshafe27714a14ed7cp1ce704jsnabbf7588f49e",
        "accept-encoding": "application/gzip",
        "content-type": "application/x-www-form-urlencoded"
    ]

    
    
    func translateSelectedWord(language: String, word: String, completionHandler: @escaping(String) ->()) {
        
        let postData = NSMutableData(data: "source=en".data(using: String.Encoding.utf8)!)
        postData.append("&q=\(word)".data(using: String.Encoding.utf8)!)
        postData.append("&target=\(language)".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = GoogleTranslateHeaders
        request.httpBody = postData as Data
  
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
     
            
            
            guard let data = data else { return }
            
            do {
                let translation = try JSONDecoder().decode(TranslatedWord.self, from: data)
                
                let translatedWord = translation.data.translations[0].translatedText
                completionHandler(translatedWord)
            }catch let error {
                print(error)
            }
            
        })

        dataTask.resume()
        
    }
    
    func fetchSearchedWords(searchWord: String, completionHandler: @escaping(Word) ->()) {
        
        guard let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(searchWord)") else { return }
        
        let request = NSMutableURLRequest(url: url ,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = WordsAPIHeaders
        
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
    
    
    
    //MARK - MEDIA/PODCASTS methods
    
    struct SearchResults : Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term" : searchText, "media" : "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { ( dataResponse ) in
            
            if let error = dataResponse.error {
                print("Failed to request data: \(error.localizedDescription)")
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do{
                let jsonResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(jsonResult.results)
            } catch let error {
                print("Decode error: \(error.localizedDescription)")
            }
        }
    }
    
    func  fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        
        DispatchQueue.global(qos: .background).async {
            let parser = FeedParser(URL: url)
            
            parser.parseAsync { (result) in
                
                if let error = result.error {
                    print("Failed to parse XML feed",  error)
                    return
                }
                
                guard let feed = result.rssFeed else { return }
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
            }
        }
    }
    
    
    
}







