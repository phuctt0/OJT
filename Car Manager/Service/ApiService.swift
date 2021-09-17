//
//  ApiService.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 02/09/2021.
//

import Foundation

protocol APIServiceProtocol {
    func fetchModelData(completion: @escaping (Result<[Model], Error>) -> Void)
}

final class ApiService: APIServiceProtocol {
    
    private var models = [Model]()
    
    func fetchModelData(completion: @escaping (Result<[Model], Error>) -> Void) {
        if models.isEmpty {
            ApiCaller.shared.getModel { [weak self] result in
                switch result {
                case .success(let object):
                    self?.models = object.models
                    completion(.success(object.models))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(models))
        }
    }
}
