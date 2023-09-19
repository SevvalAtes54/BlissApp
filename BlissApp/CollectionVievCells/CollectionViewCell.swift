//
//  CollectionViewCell.swift
//  BlissApp
//
//  Created by Macbook Air on 13.09.2023.
//

import UIKit
import SDWebImage
import TinyConstraints

class CollectionViewCell: UICollectionViewCell {
    static var identifier = "CollectionViewCell"
    var imageview: UIImageView!
    var label: UILabel!
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = .white
        imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageview)
       
        
        // UILabel oluşturun ve ayarlarını yapın
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black // Rengi istediğiniz gibi ayarlayabilirsiniz
        label.textAlignment = .center // Metni ortala
        addSubview(label)

        // UIImageView ve UILabel için constraint'leri ayarlayın
        NSLayoutConstraint.activate([
            imageview.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageview.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageview.topAnchor.constraint(equalTo: topAnchor),
            imageview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30), // 30 piksel boşluk bırak

            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: imageview.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 30) // UILabel yüksekliğini ayarlayın
        ])
    }


//    override func awakeFromNib() {
//        super.awakeFromNib()
//        let view = UIView()
//        view.backgroundColor = .white
//        imageview = UIImageView()
//
//        imageview.contentMode = .scaleAspectFit
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        label = UILabel()
//           label.translatesAutoresizingMaskIntoConstraints = false
//           label.textColor = .black // Rengi istediğiniz gibi ayarlayabilirsiniz
//           label.textAlignment = .center // Metni ortala
//           addSubview(label)
//
//           // UIImageView ve UILabel için constraint'leri ayarlayın
//           NSLayoutConstraint.activate([
//               imageview.leadingAnchor.constraint(equalTo: leadingAnchor),
//               imageview.trailingAnchor.constraint(equalTo: trailingAnchor),
//               imageview.topAnchor.constraint(equalTo: topAnchor),
//               imageview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30), // 30 piksel boşluk bırak
//
//               label.leadingAnchor.constraint(equalTo: leadingAnchor),
//               label.trailingAnchor.constraint(equalTo: trailingAnchor),
//               label.topAnchor.constraint(equalTo: imageview.bottomAnchor),
//               label.heightAnchor.constraint(equalToConstant: 30) // UILabel yüksekliğini ayarlayın
//           ])
//
//    }

    func configure(with imageURL: URL, labelText: String) {
        contentView.addSubview(label)
        label.frame = CGRect(x: 20, y: 20, width: 100, height: 30)
        imageview.sd_setImage(with: imageURL, completed: { (image, error, _, _) in
            
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            }
        })
        label.text = labelText
    }
}
