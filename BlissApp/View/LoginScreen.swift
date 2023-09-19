//
//  LoginScreen.swift
//  BlissApp
//
//  Created by Macbook Air on 16.09.2023.
//

import UIKit
import TinyConstraints
import FirebaseAuth
import FirebaseFirestore

class LoginScreen: UIViewController {
    let viewcontroller = ViewController()
    let nextcontroller = HesapOlusturView()
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
    let girisButton : UIButton = {
       let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let yeniKullaniciButton : UIButton = {
       let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 6
        return label
    }()
    let sifreUnuttumButton : UIButton = {
       let label = UIButton()
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
        view.addSubview(yeniKullaniciButton)
        view.addSubview(sifreUnuttumButton)
        
        
        karsilamaLabel.text = "Tekrar Hoşgeldin!"
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
        
        girisButton.setTitle("Giriş", for: .normal)
        girisButton.width(300)
        girisButton.height(45)
        girisButton.titleLabel?.font = .systemFont(ofSize: 25)
        girisButton.centerX(to: sifreTextfield)
        girisButton.top(to: sifreTextfield,offset: 57 )
        girisButton.backgroundColor = .systemPurple
        
       
       
        yeniKullaniciButton.setTitle("Yeni Kullanıcı", for: .normal)
        yeniKullaniciButton.titleLabel?.font = .systemFont(ofSize: 15)
        yeniKullaniciButton.top(to: girisButton,offset: 50 )
        yeniKullaniciButton.leadingToSuperview(offset: 65)
        
        
        sifreUnuttumButton.setTitle("Şifremi Unuttum", for: .normal)
        sifreUnuttumButton.titleLabel?.font = .systemFont(ofSize: 15)
        sifreUnuttumButton.trailing(to: yeniKullaniciButton,offset: 135 )
        sifreUnuttumButton.top(to: girisButton,offset: 50 )
        
        
        
        girisButton.addTarget(self, action: #selector(girisTiklandi), for: .touchUpInside)
        
        yeniKullaniciButton.addTarget(self, action: #selector(hesapOlustur), for: .touchUpInside)
        
        sifreUnuttumButton.addTarget(self, action: #selector(sifremiUnuttum), for: .touchUpInside)
        
    }
    @objc func hesapOlustur(){
        let nextVC = nextcontroller
        DispatchQueue.main.async {
        
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
     
    }
    @objc func sifremiUnuttum(){
        
    }
    
    @objc func girisTiklandi(){
        print("giris tiklandi")
        if let email = eMailTextfield.text,let password = sifreTextfield.text{
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
               
            } else {
                // Kullanıcı başarıyla giriş yaptı
//                let user = authResult?.user
               
              
                let next = self.viewcontroller
                DispatchQueue.main.async {
                    next.modalPresentationStyle = .fullScreen
                    self.present(next, animated: true)
                    self.viewcontroller.aramabuttonClicked()
                }
               
            }
        }
}
    }
    
  
   
   

}
