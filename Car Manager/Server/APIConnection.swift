//
//  APIConnection.swift
//  Car Manager
//
//  Created by Trần Thế Phúc on 20/08/2021.
//

import Foundation

protocol APIConnectionProtocol {
    func fetchAPIFromURL(_ url: String, complitionHandler: @escaping (String?, String?) -> Void)
}

class APIConnection {
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    private let domain = "https://"
}

extension APIConnection: APIConnectionProtocol {
    func fetchAPIFromURL(_ url: String, complitionHandler: @escaping (String?, String?) -> Void) {
        guard let url = URL(string: "\(domain)\(url)") else {
            complitionHandler(nil, "URL incorrect")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error?.localizedDescription {
                complitionHandler(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                complitionHandler(nil, "HTTP status failed")
                return
            }
            guard let dataa = data else {
                return
            }
            let string = String(data: dataa, encoding: .utf8)
            complitionHandler(string, nil)
        }
        dataTask?.resume()
    }
}

