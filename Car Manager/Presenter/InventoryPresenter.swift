//
//  InventoryPresenter.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 02/09/2021.
//

import Foundation

protocol InventoryPresenterDelegate: AnyObject {
    func updateUI(for models: [Model])
}

final class InventoryPresenter {
    private weak var delegate: InventoryPresenterDelegate?
    private let service: ApiService!
    
    private let dispatchGroup = DispatchGroup()
    
    init(view: InventoryPresenterDelegate, service: ApiService) {
        delegate = view
        self.service = service
    }
    
    func fetchData(completitionHandler: @escaping ([Model]) -> Void) {
        let url = URL(string: "https://6136e4028700c50017ef56d5.mockapi.io/products")!
        let task = URLSession.shared.dataTask(with: url) {
            (data,response,error) in
            guard let data = data else { return }
            do {
                let postData = try JSONDecoder().decode([Model].self,from: data)
                completitionHandler(postData)
            }
            catch {
                let error = error
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchModel() {
        service.fetchModelData { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.delegate?.updateUI(for: model)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
