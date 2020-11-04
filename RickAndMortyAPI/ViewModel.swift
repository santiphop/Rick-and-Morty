//
//  ViewModel.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 1/11/2563 BE.
//

import Foundation

class ResultViewModel {
    
    typealias completionBlock = (Character) -> ()
    var apiRequest = APIRequest()
    var results = [ResultInfo]()
    var infoData = InfoData(count: nil, pages: nil, next: nil, prev: nil)
    
    
    func getDataFromAPIRequest(url: String, completionBlock : @escaping completionBlock){
        
        apiRequest.getDataFromAPI(url: url) { [weak self] (data) in
            self?.infoData = data.info!
            self?.results = data.results
            completionBlock(data)
        }
        
    }
    
//    func getNumberOfRowsInSection() -> Int{
//        
//        return datasourceArray.count
//    }
//    
//    func getUserAtIndex(index : Int) -> User{
//        
//        let user = datasourceArray[index]
//        return user
//    }
//    
//    func getCellData(index : Int) -> String{
//        
//        let user = self.getUserAtIndex(index: index)
//        
//        let userId = user.userId ?? 0
//        let id = user.id ?? 0
//        let body = user.body ?? ""
//        let title = user.title ?? ""
//        let res = "\(userId)" + " " + "\(id)" + " " + (body) + " " + (title)
//        return res
//    }
//    var apiRequest = APIRequest()
//    var results = [ResultInfo]()
//    var infoData = InfoData(count: nil, pages: nil, next: nil, prev: nil)
//
//    func getDataFromAPIHandleClass(url:String, completion: @escaping (Character) -> ()) {
//        
////        apiRequest.getResultDataFromAPI(url: url) { [weak self] result in
////            switch result {
////            case .failure(let err):
////                print(err)
////            case .success(let results):
////                self!.characters = results
////            }
////            
////        }
////        
////        apiRequest.getInfoDataFromAPI(url: url) { [weak self] result in
////            switch result {
////            case .failure(let err):
////                print(err)
////            case .success(let info):
////                self!.infoData = info
////            }
////            
////        }
//        
//        apiRequest.getDataFromAPI(url: url) { [weak self] data in
//            switch data {
//            case .failure(let err):
//                print(err)
//            case .success:
//                self!.results = data.results
//                self!.infoData = data.info
//            }
//            
//        }
//    }
    
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
