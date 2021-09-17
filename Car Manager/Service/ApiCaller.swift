//
//  ApiCaller.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 08/09/2021.
//

import Foundation
import UIKit
import Alamofire

final class ApiCaller {
    static let shared = ApiCaller()
    private init() {}
    
    private let baseUrl: String = "https://6136e4028700c50017ef56d5.mockapi.io/products"
    
    private enum APIError: Error {
        case failedToGetData
        case failedToGetURL
        case failedToDownloadImage
        case failedConvertDataToImage
    }
    
    
    func getModel(completion: @escaping (Result<ModelArr, Error>) -> Void) {
        let urlString: String = baseUrl
        request(for: urlString, completion: completion)

    }
    
    func request<T: Decodable>(for urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.failedToGetURL))
            return
        }
        
        call(with: url, completion: completion)
    }
    
    func call<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
                print("succes")
            } catch {
                completion(.failure(error))
                print("fail")
            }
        }
        dataTask.resume()
    }
}
