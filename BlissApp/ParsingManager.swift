//
//  ParsingManager.swift
//
//
//  Created by Macbook Air on 31.08.2023.
//

import Foundation

protocol ParsingManagerDelegate : AnyObject{
    func parseUpdated(gonderildiVeri: ShopScreenModel, _ manager : ParsingManager)
    func parseForInstances(instanceVeri : [ShopScreenModel]?, _ manager : ParsingManager)
    
}

struct ParsingManager {
    
    let delegate : ParsingManagerDelegate?
    let url =  "https://api.escuelajs.co/api/v1/products/?title="
    func fetchUrl(filter : String) {
        let filteredUrl = "\(url)\(filter)"
        performRequest(sendedUrl: filteredUrl)
        
    }
    func performRequest(sendedUrl : String) {
    
        if let URL = URL(string: sendedUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: URL) { data, response, error in
                if error != nil {
              //      print(error)
                }
                if let safeUrl = data {
                    if let decoded = parseJson(gelenData: safeUrl){
                       
                        self.delegate?.parseUpdated(gonderildiVeri: decoded,self)
                    }
                    if let decoded2 = parseJsonForAllInstances(gelendata: safeUrl){
                        self.delegate?.parseForInstances(instanceVeri: decoded2,self)
                    }
                }
            }
            task.resume()
        }
        
    }
    
}
func parseJsonForAllInstances(gelendata: Data) -> [ShopScreenModel]?{
    
    let decoder = JSONDecoder()
    var dizi: [ShopScreenModel]? = []
    do {
           let items = try decoder.decode([ShopScreenData].self, from: gelendata)
       
           for item in items {
               let title = item.title
               let resim = item.category.image
               let fiyat = item.price
               let aciklama = item.description
               dizi?.append(ShopScreenModel(id: 0, baslik: title, fiyat: String(fiyat), aciklama: aciklama, images: ["",""], yaratimZamani: "", guncellemeZamani: "", kategori: Categories(image: resim, name: "")))
               
               print("Title: \(title)")
               
           }
//        print(dizi )
        return dizi
//        return dizi
       } catch {
           print(error)
       }
  return dizi
}



func parseJson(gelenData: Data) -> ShopScreenModel? {
    let decoder = JSONDecoder()
 
   
    do {
        let asd = try decoder.decode([ShopScreenData].self, from: gelenData)
        guard let decoded = asd.first else {
            return nil
        }
        
        // Assuming you have an array of image URLs or strings in `decoded.images`
        let images = decoded.images.map { imageURLString in
            // Convert imageURLString to URL if it's a string
            if let url = URL(string: imageURLString) {
                return url.absoluteString
            } else {
                return imageURLString // Use as is if it's already a URL string
            }
        }
        
        let aciklama = decoded.description
        let yapilmaZamani = decoded.creationAt
        let identifikasyon = Int(decoded.id)
        let parasi = String(decoded.price)
        let baslik = decoded.title
        let updateZamani = decoded.updatedAt
        let kategori = Categories(image: decoded.category.image, name: decoded.category.name)
        
        let dondurulcekModel = ShopScreenModel(id: identifikasyon, baslik: baslik, fiyat: parasi, aciklama: aciklama, images: images, yaratimZamani: yapilmaZamani, guncellemeZamani: updateZamani, kategori: kategori)
        
        print(dondurulcekModel)
        return dondurulcekModel
    } catch {
        print(error)
        return nil
    }
}



