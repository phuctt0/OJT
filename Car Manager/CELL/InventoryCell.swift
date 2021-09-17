//
//  InventoryCell.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 19/08/2021.
//

import UIKit
import Foundation
class InventoryCell: UICollectionViewCell {

    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var imageCar: UIImageView!
    @IBOutlet weak var nameCar: UILabel!
    @IBOutlet weak var priceCar: UILabel!
    @IBOutlet weak var star: UIButton!
    var isChoose: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setRadius(by: 10, isShadow: false)
        fixShadowPath()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageCar.image = nil
    }
    
    let imageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.clipsToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
    
    @IBAction func onPressFavourite(_ sender: Any) {
        isChoose = !isChoose
        if isChoose {
            let btnImage = UIImage(named: "star_fill")
            favouriteBtn.setImage(btnImage , for: .normal)
            print("fill")
        }
        else {
            let btnImage = UIImage(named: "star")
            favouriteBtn.setImage(btnImage , for: .normal)
            print("non-fill")
        }
    }
}
