//
//  InventoryController.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 19/08/2021.
//

import UIKit
import Foundation
import  Alamofire
import AlamofireImage

protocol ProductListViewPresenter {
    func showProductList()
}

class InventoryController: UIViewController {
    var listModel = [Model]()
    private var models = [Model]()
    var size: Int = 0
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private var apiService: ApiService!
    private var presenter: InventoryPresenter!
    @IBOutlet weak var collectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCell()
        fetchData()
//        presenter = InventoryPresenter(view: self, service: ApiService())
//        presenter.fetchModel()
        // Do any additional setup after loading the view.

//        apiService.fetchModelData { (models) in
//            DispatchQueue.main.async {
//                self.listModel = models
//                self.collectionView.reloadData()
//
//            }
//        }
    }
    @objc func refresh(_ sender:AnyObject) {
       //do refreshing stuff
        self.refreshControl.endRefreshing()
              collectionView.reloadData()
   }
}

// MARK: Collection View Delegate
//extension InventoryController: UICollectionViewDelegate {
//    // MARK: - UICollectionView Delegate
//        func collectionView(_ collectionView: UICollectionView,
//                                     willDisplay cell: UICollectionViewCell,
//                                     forItemAt indexPath: IndexPath) {
//
//            // 1
//            guard let cell = cell as? InventoryCell else { return }
//
//            // 2
//            let itemNumber = NSNumber(value: indexPath.item)
//
//            // 3
//            if let cachedImage = self.cache.object(forKey: itemNumber) {
//                print("Using a cached image for item: \(itemNumber)")
//                cell.imageCar.image = cachedImage
//            } else {
//                // 4
//                self.loadImage { [weak self] (image) in
//                    guard let self = self, let image = image else { return }
//
//                    cell.imageCar.image = image
//
//                    // 5
//                    self.cache.setObject(image, forKey: itemNumber)
//                }
//            }
//    }
//}

// MARK: Collection View DataSource
extension InventoryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listModel.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryCell", for: indexPath) as? InventoryCell {
            
            let urlString =  listModel[indexPath.row].image
            cell.imageCar.downloaded(from: urlString)

            cell.nameCar.text = listModel[indexPath.row].name
            cell.priceCar.text = listModel[indexPath.row].price
            
            		
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ViewDetailController", sender: self)
        print(indexPath.row)
    }
}

// MARK: Collection View Flow LayOut
extension InventoryController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3   * 10 ) / 2
        let height = width * 2
        return CGSize(width: width, height: height)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK: Extensions Inventory Controller
extension InventoryController {
    func setupCollectionView() {
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.alwaysBounceVertical = true
          self.refreshControl = UIRefreshControl()
          self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
          self.refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
          collectionView!.addSubview(refreshControl)
    }
    
//    func loadImage(completion: @escaping (UIImage?) -> ()) {
//        utilityQueue.async {
//            let url = URL(string: "https://picsum.photos/200")!
//            guard let data = try? Data(contentsOf: url) else { return }
//            let image = UIImage(data: data)
//
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }
//    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "InventoryCell", bundle: nil),forCellWithReuseIdentifier: "InventoryCell")
    }
    
    func fetchData() {
        AF.request("https://6136e4028700c50017ef56d5.mockapi.io/products").response { response in
            guard let data = response.data else {
                return
            }
            do {
                let cars = try JSONDecoder().decode([Model].self, from: data)
                self.listModel = cars
                self.collectionView.reloadData()
//                print(cars)
            }
            catch {
                print(error)
            }
        }
    }
}


extension InventoryController: InventoryPresenterDelegate {
    func updateUI(for models: [Model]) {
        self.models = models
        collectionView.reloadData()
    }
}
