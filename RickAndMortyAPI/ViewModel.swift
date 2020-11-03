//
//  ViewModel.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 1/11/2563 BE.
//

import Foundation

class ResultViewModel {
    var apiRequest = APIRequest()
    var characters = [ResultInfo]()
    var infoData = InfoData(count: nil, pages: nil, next: nil, prev: nil)

    func getDataFromAPIHandleClass(url:String) {
        
        apiRequest.getResultDataFromAPI(url: url) { [weak self] result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let results):
                self!.characters = results
            }
            
        }
        
        apiRequest.getInfoDataFromAPI(url: url) { [weak self] result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let info):
                self!.infoData = info
            }
            
        }
    }
    
//    func getNumberOfRowsInSection() -> Int {
//        print("return \(characters.count)")
//        return characters.count
//    }
//    
//    func getResult(at index: Int) -> ResultInfo {
//        let result = characters[index]
//        return result
//    }

}
