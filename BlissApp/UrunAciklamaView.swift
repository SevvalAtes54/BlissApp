//
//  UrunAciklamaView.swift
//  
//
//  Created by Macbook Air on 3.09.2023.
//
//
//let baslik : String
//let fiyat : String
//let aciklama : String
//
//let yaratimZamani : String
//let guncellemeZamani : String
//let kategori : Categories
//
//
//}
//struct Categories{
////    let id : String
//let image : String
////    let creationAt : String
//let name : String
////    let updatedAt : String
//}
//
//UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonClicked))
// backButton.customView?.backgroundColor = .systemBlue
// urunAciklamaViewController.navigationItem.leftBarButtonItem = backButton



import UIKit
import TinyConstraints
protocol urunaciklamaDelegate : AnyObject{
    func veriyiTransfer(veri : ShopScreenModel)
}
class UrunAciklamaView: UIViewController {
    // var urunaciklamadelegate = urunaciklamaDelegate()
    var parsingManager: ParsingManager?
    var veri: String?
    var arananUrun : String?
    var verimodel : ShopScreenModel?
    var backButton: UIBarButtonItem!
    let gorunusImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let urunAciklamasiTextfield : UITextView = {
        let aciklama = UITextView()
        aciklama.translatesAutoresizingMaskIntoConstraints = false
        return aciklama
    }()
    let urunBasligi : UILabel = {
        let baslik = UILabel()
        baslik.translatesAutoresizingMaskIntoConstraints = false
        return baslik
    }()
    let urunFiyatLabel : UILabel = {
        let fiyat = UILabel()
        fiyat.translatesAutoresizingMaskIntoConstraints = false
        return fiyat
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(gorunusImageView)
        view.addSubview(urunBasligi)
        view.addSubview(urunFiyatLabel)
        
        //        view.addSubview(viewcontroller.backButton)
        //        viewcontroller.backButton.topToSuperview(offset: 35)
        //        viewcontroller.backButton.topToSuperview(offset: 35)
        gorunusImageView.translatesAutoresizingMaskIntoConstraints = false
        urunBasligi.translatesAutoresizingMaskIntoConstraints = false
        urunFiyatLabel.translatesAutoresizingMaskIntoConstraints = false
        urunAciklamasiTextfield.translatesAutoresizingMaskIntoConstraints = false
        
        
        gorunusImageView.centerXToSuperview()
        gorunusImageView.topToSuperview(offset:50)
        gorunusImageView.width(345)
        gorunusImageView.height(345)
        gorunusImageView.backgroundColor = .orange
        
        
        view.addSubview(urunBasligi)
        urunBasligi.bottom(to: gorunusImageView,offset: 25)
        urunBasligi.textColor = .black
        urunBasligi.font = .boldSystemFont(ofSize: 14)
//        urunBasligi.leadingToSuperview(offset: 12)
        urunBasligi.centerXToSuperview()
        urunBasligi.textColor = .black
        urunBasligi.font = .boldSystemFont(ofSize: 20)
        
        view.addSubview(urunFiyatLabel)
        urunFiyatLabel.bottom(to: urunBasligi,offset: 25)
        urunFiyatLabel.textColor = .systemOrange
     
//        urunBasligi.leadingToSuperview(offset: 12)
        urunFiyatLabel.centerXToSuperview()
     
        urunFiyatLabel.font = .boldSystemFont(ofSize: 20)
        
        
     
        view.addSubview(urunAciklamasiTextfield)
        urunAciklamasiTextfield.backgroundColor = .clear
        urunAciklamasiTextfield.width(300)
        urunAciklamasiTextfield.height(300)
        urunAciklamasiTextfield.top(to: urunFiyatLabel,offset: 25)
        urunAciklamasiTextfield.textColor = .black
        urunAciklamasiTextfield.font = .systemFont(ofSize: 18)
//        urunBasligi.leadingToSuperview(offset: 12)
        urunAciklamasiTextfield.leadingToSuperview(offset: 15)
        // UINavigationBar oluşturun
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
        
        // UINavigationItem oluşturun ve başlığı ayarlayın
       
        let navigationItem = UINavigationItem(title: verimodel!.baslik)
        
        // Geri Dönüş Butonunu Özelleştirin
        backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(geriButonunaTiklandi))
        navigationItem.leftBarButtonItem = backButton
        
        // UINavigationBar'a UINavigationItem'ı Eklemek
        navigationBar.items = [navigationItem]
        
        // UINavigationBar'ı Görünüme Eklemek ve TinyConstraints ile Konumlandırmak
        navigationBar.topToSuperview(usingSafeArea: true)
        navigationBar.leadingToSuperview()
        navigationBar.trailingToSuperview()
        
    }
    @objc func geriButonunaTiklandi() {
        // Geri butonuna tıklandığında yapılacak işlemleri burada gerçekleştirin
        print("Geri butonuna tıklandı!")
//        self.dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
       let nextViewController = ViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: false)
        nextViewController.textArama = arananUrun
        nextViewController.aramabuttonClicked()
        
        
    }
    func veriyiTransfer(veri : ShopScreenModel){
        print("veri.baslik YAZILMASIA ÇALIIILDI")
        print(veri.baslik)
        //  urunBasligi.text = veri.baslik
        
    }
    
    
    
    func transferEdildi(transfer: ShopScreenModel) {
        DispatchQueue.global().async { // Arka planda çalıştır
            if let imageURL = URL(string: transfer.kategori.image) {
                let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    if let error = error {
                        print("Hata: \(error)")
                    } else if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.gorunusImageView.image = image
                            self.urunBasligi.text = transfer.baslik
                            self.urunFiyatLabel.text = "\(transfer.fiyat)₺"
                            self.urunAciklamasiTextfield.text = transfer.aciklama
                           
                         
                            
                        }
                    } else {
                        print("Görüntü yüklenemedi.")
                    }
                }
                task.resume()
            }
        }
    }
}
