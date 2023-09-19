//
//  HesapOlusturView.swift
//  BlissApp
//
//  Created by Macbook Air on 17.09.2023.
//

import UIKit
import TinyConstraints
import FirebaseAuth
import FirebaseFirestore

class HesapOlusturView: UIViewController {
    var backButton: UIBarButtonItem!
    let nextVC = ViewController()
    let karsilamaLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let eMailLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tekrarSifre : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sifreLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let eMailTextfield : UITextField = {
       let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let sifreTextfield : UITextField = {
       let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let tekrarSifreTextfield : UITextField = {
       let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let girisButton : UIButton = {
       let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let sihirButton : UIButton = {
       let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let uyariLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        view.addSubview(karsilamaLabel)
        view.addSubview(eMailLabel)
        view.addSubview(eMailTextfield)
        view.addSubview(sifreLabel)
        view.addSubview(sifreTextfield)
        view.addSubview(girisButton)
        view.addSubview(tekrarSifre)
        view.addSubview(tekrarSifreTextfield)
        view.addSubview(sihirButton)
        view.addSubview(uyariLabel)
        
        karsilamaLabel.text = "Aramıza Hoşgeldin!"
        karsilamaLabel.font = .boldSystemFont(ofSize: 40)
        karsilamaLabel.centerXToSuperview()
        karsilamaLabel.topToSuperview(offset: 120)
        
        eMailLabel.text = "E-posta"
        eMailLabel.font = .systemFont(ofSize: 20)
        eMailLabel.leadingToSuperview(offset: 20)
        eMailLabel.top(to: karsilamaLabel,offset: 100)
        
        eMailTextfield.placeholder = "E-posta girin"
        eMailTextfield.font =  .systemFont(ofSize: 20)
        eMailTextfield.leadingToSuperview(offset: 20)
        eMailTextfield.top(to: eMailLabel,offset: 32)
        eMailTextfield.backgroundColor = .white
        eMailTextfield.width(300)
        eMailTextfield.height(38)
        
        sifreLabel.text = "Şifre"
        sifreLabel.font = .systemFont(ofSize: 20)
        sifreLabel.leadingToSuperview(offset: 20)
        sifreLabel.top(to: eMailTextfield,offset: 80)
        
        sifreTextfield.placeholder = "Şifre girin"
        sifreTextfield.font =  .systemFont(ofSize: 20)
        sifreTextfield.leadingToSuperview(offset: 20)
        sifreTextfield.top(to: sifreLabel,offset: 32)
        sifreTextfield.backgroundColor = .white
        sifreTextfield.width(300)
        sifreTextfield.height(38)
//       sifreTextfield.isSecureTextEntry = true
        
        tekrarSifre.text = "Şifre"
        tekrarSifre.font = .systemFont(ofSize: 20)
        tekrarSifre.leadingToSuperview(offset: 20)
        tekrarSifre.top(to: sifreTextfield,offset: 80)
        
        tekrarSifreTextfield.placeholder = "Şifreyi tekrar girin"
        tekrarSifreTextfield.font =  .systemFont(ofSize: 20)
        tekrarSifreTextfield.leadingToSuperview(offset: 20)
        tekrarSifreTextfield.top(to: tekrarSifre,offset: 32)
        tekrarSifreTextfield.backgroundColor = .white
        tekrarSifreTextfield.width(300)
        tekrarSifreTextfield.height(38)
        tekrarSifreTextfield.isSecureTextEntry = true
        
        
        girisButton.setTitle("Kaydol", for: .normal)
        girisButton.width(300)
        girisButton.height(45)
        girisButton.titleLabel?.font = .systemFont(ofSize: 25)
        girisButton.centerX(to: sifreTextfield)
        girisButton.top(to: tekrarSifreTextfield,offset: 57 )
        girisButton.backgroundColor = .systemPurple
        
        girisButton.addTarget(self, action: #selector(girisTiklandiKullaniciOlustu), for: .touchUpInside)
        
//        ─── ･ ｡ﾟ☆: *.☽ .* :☆ﾟ. ───
        sihirButton.setTitle("✯☆ﾟ.•´*¨`Sihir`*☆*`☆✯ ", for: .normal)
        sihirButton.width(300)
        sihirButton.height(45)
        sihirButton.titleLabel?.font = .systemFont(ofSize: 25)
        sihirButton.centerX(to: sifreTextfield)
        sihirButton.top(to: girisButton,offset: 57 )
        sihirButton.backgroundColor = .systemPurple
        
        sihirButton.addTarget(self, action: #selector(sihirButon), for: .touchUpInside)
        
        uyariLabel.text = ""
        uyariLabel.font = .systemFont(ofSize: 20)
        uyariLabel.leadingToSuperview(offset: 20)
        uyariLabel.top(to: sihirButton,offset: 80)
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .systemMint
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
        
        // UINavigationItem oluşturun ve başlığı ayarlayın
       
        let navigationItem = UINavigationItem(title: "Hesap Oluştur")
        
        backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(geriButonunaTiklandi))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
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
       let nextViewController = LoginScreen()
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: false)
       
        
        
        
    }
    @objc func  girisTiklandiKullaniciOlustu () {
        if  let email = self.eMailTextfield.text, let sifre = self.sifreTextfield.text, let tekrar = self.tekrarSifreTextfield.text {
            if tekrar == sifre {
                DispatchQueue.main.async{
                Auth.auth().createUser(withEmail: email, password: sifre) { (authResult, error) in
                    if let error = error {
                        print("Kullanıcı oluşturulurken hata oluştu: \(error.localizedDescription)")
                    } else if let user = authResult?.user {
                        print("Kullanıcı başarıyla oluşturuldu: \(user.uid)")
                        // Kullanıcı başarıyla oluşturulduysa bir sonraki adıma geçebilirsiniz.
                    }
                }
            }} else {
                self.uyariLabel.text = "Şifreler eşleşmiyor!"
                self.uyariLabel.textColor = .red
            }
        }
      
        let next = nextVC
        DispatchQueue.main.async {
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true)
            self.nextVC.aramabuttonClicked()
        }
    }

//    @objc func  girisTiklandiKullaniciOlustu (){
//        if  let tekrar =  self.tekrarSifreTextfield.text, let sifretext = self.sifreTextfield.text {
//
//            if tekrar == sifretext{
//                DispatchQueue.main.async {
//                    if let email =  self.eMailLabel.text, let sifre = self.sifreLabel.text
//                    {
//                        Auth.auth().createUser(withEmail: email , password: sifre ) { (authResult, error) in
//                            if let error = error {
//                                print("Kullanıcı oluşturulurken hata oluştu: \(error.localizedDescription)")
//                            } else {
//                                print("Kullanıcı başarıyla oluşturuldu: a \(authResult?.user.uid ?? "")")
//                                // Kullanıcı başarıyla oluşturulduysa bir sonraki adıma geçebilirsiniz.
//                            }
//                        }
//
//                    }
//                }
//            }
//            else {
//                self.uyariLabel.text = "Şifreler eşleşmiyor!"
//                self.uyariLabel.textColor = .red
//            }
//        }
//
//        let next = nextVC
//        DispatchQueue.main.async{
//            next.modalPresentationStyle = .fullScreen
//            self.present(next, animated: true)
//
//        }
//    }
    @objc func  sihirButon (){
//        tekrarSifreTextfield.isSecureTextEntry.toggle()
        sifreTextfield.isSecureTextEntry.toggle()
    }
    

}
