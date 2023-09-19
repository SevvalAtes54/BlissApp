//
//  AppDelegate.swift
//  BlissApp
//
//  Created by Macbook Air on 31.08.2023.
//

import UIKit
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let loginScreen = UrunAciklamaView() // Login ekranını oluşturun
//          let navigationController = UINavigationController(rootViewController: loginScreen)
//          window = UIWindow(frame: UIScreen.main.bounds)
//          window?.rootViewController = navigationController
//          window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
//
////
////  ParsingManager.swift
////
////
////  Created by Macbook Air on 31.08.2023.
////
//
//import Foundation
//
//protocol ParsingManagerDelegate{
//    func parseUpdated()
//
//}
//
//struct ParsingManager {
//
//
//    let url =  "https://api.escuelajs.co/api/v1/products/"
//    func fetchUrl(filter : String) {
//        let filteredUrl = "\(url)\(filter)"
//        performRequest(sendedUrl: filteredUrl)
//
//    }
//    func performRequest(sendedUrl : String) {
//        if let URL = URL(string: sendedUrl){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: URL) { data, response, error in
//                if error != nil {
//                    print(error)
//                }
//                if let safeUrl = data {
//                    // parseJson (gelenData: safeUrl)
//                }
//            }
//            task.resume()
//        }
//
//    }
//
//}
//func parseJson (gelenData: Data) ->  ShopScreenModel? {
//        let decoder = JSONDecoder()
//
//        do {
//          let asd =  try  decoder.decode([ShopScreenData].self, from: gelenData)
//            guard let decoded = asd.first else{
//                return nil
//            }
//
//            let aciklama = decoded.description
//            let yapilmaZamani = decoded.creationAt
//            let identifikasyon = decoded.id
//
//            let parasi = decoded.price
//            let baslik = decoded.title
//            let updateZamani = decoded.updatedAt
//            let kategori = Categories(image: decoded.category.image, name: decoded.category.name)
//            let dondurulcekModel =  ShopScreenModel(id: identifikasyon, baslik: baslik, fiyat: parasi, aciklama: aciklama, yaratimZamani: yapilmaZamani, guncellemeZamani: updateZamani, kategori: kategori )
//            return dondurulcekModel
//        } catch {
//            print(error)
//            return nil
//        }
//
//
//    }
//
//
//
