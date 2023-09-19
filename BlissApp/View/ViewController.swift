import UIKit
import TinyConstraints
import SDWebImage

class ViewController: UIViewController, ParsingManagerDelegate, UITextFieldDelegate, UITextViewDelegate,urunaciklamaDelegate {
   
    
   
    
    
   
    
    var instanceVeri :  [ShopScreenModel]?
    
    var collectionView: UICollectionView!
    var gonderildiVeri: ShopScreenModel?
    var imageGelen = UIImage()
    
    let urunAciklamaViewController = UrunAciklamaView()
    var parsingManager: ParsingManager?
    var textArama : String? = "car"
    
    let backButton: UIButton = {
        let buton = UIButton()
        buton.translatesAutoresizingMaskIntoConstraints = false
        buton.setTitleColor(.systemBlue, for: .normal)
        return buton
    }()
    
    let labelTanitmaUrun: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let aramaButtonView: UIButton = {
        let buton = UIButton()
        buton.translatesAutoresizingMaskIntoConstraints = false
        buton.setTitle("", for: .normal)
        buton.layer.cornerRadius = 8
        buton.backgroundColor = .white
        return buton
    }()
    
    let textfieldArama: UITextField = {
        let textfield = UITextField()
        textfield.layer.cornerRadius = 8
        textfield.backgroundColor = .white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    override func loadView() {
        super.loadView()
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        layout.itemSize = CGSize(width: (view.frame.size.width/2.01),
                                 height: (view.frame.size.width/2.01))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addSubview(textfieldArama)
        collectionView.topToBottom(of: textfieldArama, offset: 20)
        collectionView.leadingToSuperview()
        collectionView.trailingToSuperview()
        collectionView.bottomToSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        parsingManager = ParsingManager(delegate: self)
        textfieldArama.isEnabled = true
        aramaButtonView.addTarget(self, action: #selector(aramabuttonClicked), for: .touchUpInside)
        textfieldArama.translatesAutoresizingMaskIntoConstraints = false
        aramaButtonView.translatesAutoresizingMaskIntoConstraints = false
        textfieldArama.placeholder = "search"
        view.addSubview(labelTanitmaUrun)
        view.addSubview(aramaButtonView)
        view.addSubview(textfieldArama)
        textfieldArama.topToSuperview(offset: 100)
        textfieldArama.leadingToSuperview(offset: 15)
        textfieldArama.width(300)
        textfieldArama.height(50)
        textfieldArama.backgroundColor = .systemGray5
        aramaButtonView.trailingToSuperview(offset: 15)
        aramaButtonView.width(50)
        aramaButtonView.height(50)
        aramaButtonView.topToSuperview(offset: 100)
        aramaButtonView.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    func gel(geldi:String){
        
    }
    
    @objc func aramabuttonClicked() {
        print("aramabuttonClicked")
        
        if let asd = textfieldArama.text {
            parsingManager?.fetchUrl(filter: asd)
            urunAciklamaViewController.arananUrun = asd
            
        }
    }
    
    @objc func resimbuttonClicked() {
        print("resimbuttonClicked")
        let urunAciklamaViewController = UrunAciklamaView()
        urunAciklamaViewController.veri = "Göndermek istediğiniz veri"
        addChild(urunAciklamaViewController)
        view.addSubview(urunAciklamaViewController.view)
        urunAciklamaViewController.didMove(toParent: self)
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textfieldArama.text != "" {
            return true
        } else {
            textfieldArama.placeholder = "Search anything"
            return false
        }
    }
    
    @IBAction func aramaButtonView(sender: Any?) {
        textfieldArama.endEditing(true)
    }
    
    private func textFieldShouldBeginEditing(_ textField: UITextField) {
        textfieldArama.placeholder = "Search anything"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, parsingManager: ParsingManager) {
        textfieldArama.text = ""
    }
    func parseForInstances(instanceVeri: [ShopScreenModel]?, _ manager: ParsingManager) {
        print("parseUpdated çağrıldı.")
        self.instanceVeri = instanceVeri
        DispatchQueue.main.async {
            self.instanceVeri = instanceVeri
            self.collectionView.reloadData()
        }
//        self.collectionView.reloadData()
    }
    func parseUpdated(gonderildiVeri: ShopScreenModel, _ manager: ParsingManager) {
        print("parseUpdated çağrıldı.")
        self.gonderildiVeri = gonderildiVeri
        handleFetchedData(veri: gonderildiVeri)
        
    }
    func veriyiTransfer(veri: ShopScreenModel) {
        print(veri)
        urunAciklamaViewController.transferEdildi(transfer: veri)
        urunAciklamaViewController.verimodel = veri
        
    }
    func handleFetchedData(veri: ShopScreenModel) {
        DispatchQueue.main.async {
//            self.labelTanitmaUrun.text = "Found \(veri.images.count) images."
            self.collectionView.reloadData()
        }
    }
    
}
extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let instancecount = instanceVeri?.count {
             return instancecount
         } else {
             return 0 // Opsiyonel değer nil ise, 0 elemanı olduğunu döndür
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = urunAciklamaViewController
        let path = indexPath.row
        if let instanceVeri = instanceVeri {
            veriyiTransfer(veri: instanceVeri[path])
            DispatchQueue.main.async {
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: false)
            }
        } else {
            // Hata işleme kodunu burada ekleyebilirsiniz.
        }
    }

  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell

        if let veri = instanceVeri, indexPath.row < veri.count {
            let element = veri[indexPath.row]
            if let imageURL = URL(string: element.kategori.image) {
                cell.configure(with: imageURL, labelText: element.baslik)
            } else {
                print("Invalid image URL: \(element.kategori.image)")
            }
        }

        return cell
    }

}
