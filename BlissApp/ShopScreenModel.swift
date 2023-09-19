//
//  ShopScreenModel.swift
//
//
//  Created by Macbook Air on 31.08.2023.
//

import Foundation


struct ShopScreenModel {
    let id : Int
    let baslik : String
    let fiyat : String
    let aciklama : String
    let images : [String]
    let yaratimZamani : String
    let guncellemeZamani : String
    let kategori : Categories
   
    
}
struct Categories{
//    let id : String
    let image : String
//    let creationAt : String
    let name : String
//    let updatedAt : String
}
