//
//  Model.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 20/08/2021.
//

import Foundation
import UIKit

struct ModelArr: Decodable {
    let models: [Model]
}
struct Model: Codable {
    let image: String
    let name: String
    let price: String
}
