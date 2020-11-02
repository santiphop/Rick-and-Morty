//
//  APIHandler.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 1/11/2563 BE.
//

import Foundation

class APIRequest {
    func getResultDataFromAPI(
        url:String,
        completion: @escaping(Result<[ResultInfo], ResultError>) -> Void) {
        let jsonUrlString = url
        let url = URL(string: jsonUrlString)!
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
           
            do {
                let characters = try JSONDecoder().decode(Character.self, from: data)
                let results = characters.results
//                print(results.count)
                completion(.success(results))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            
                        
            
        }
        
        task.resume()
    }
    
    func getInfoDataFromAPI(
        url:String,
        completion: @escaping(Result<InfoData, ResultError>) -> Void) {
        let jsonUrlString = url
        let url = URL(string: jsonUrlString)!
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
           
            do {
                let characters = try JSONDecoder().decode(Character.self, from: data)
                let info = characters.info
//                print(info.next!)
                completion(.success(info))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            
                        
            
        }
        
        task.resume()
    }
    
    
    
}

enum ResultError:Error {
    case noDataAvailable
    case canNotProcessData
}