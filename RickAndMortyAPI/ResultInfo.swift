//
//  ResultInfo.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 1/11/2563 BE.
//

import Foundation

struct Character: Decodable {
    let info: InfoData?
    let results: [ResultInfo]
}

struct InfoData: Decodable {
    let count:Int?
    let pages:Int?
    let next:String?
    let prev:String?
}

struct ResultInfo: Decodable {
    let id:Int
    let name:String
    let status:String?
    let species:String?
    let gender:String?
    let image:String?
    let origin:Origin?
    let location:Location?
    
}

struct Origin: Decodable {
    let name:String?
}

struct Location: Decodable {
    let name:String?
}
