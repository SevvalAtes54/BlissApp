//
//  ShopScreenModel.swift
//
//
//  Created by Macbook Air on 31.08.2023.
//


//
//[
//{
//"id": 1,
//"title": "Awesome Steel Chicken",
//"price": 767,
//"description": "New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart",
//"images": [
//"https://picsum.photos/640/640?r=7251",
//"https://picsum.photos/640/640?r=1358",
//"https://picsum.photos/640/640?r=3835"
//],
//"creationAt": "2023-08-31T00:59:30.000Z",
//"updatedAt": "2023-08-31T00:59:30.000Z",
//"category": {
//"id": 3,
//"name": "Furniture",
//"image": "https://picsum.photos/640/640?r=2815",
//"creationAt": "2023-08-31T00:59:30.000Z",
//"updatedAt": "2023-08-31T00:59:30.000Z"
//}
//},


import Foundation

struct ShopScreenData : Codable{
    let id : Int
    let title : String
    let price : Int
    let description : String
    let images : [String]
    let creationAt : String
    let updatedAt : String
    let category : Categorie
   
    
}

struct Categorie : Codable{
    let id : Int
    let image : String
    let creationAt : String
    let name : String
    let updatedAt : String
}
