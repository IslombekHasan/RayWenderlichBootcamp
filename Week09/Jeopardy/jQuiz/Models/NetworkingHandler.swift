//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

typealias FullCompletionBlock = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
typealias DataCompletionBlock = (_ data: Data) -> ()

class Networking {
    private let baseURL = "https://jservice.io/api/"
    private let random = "random"
    private let categories = "categories"
    private let clues = "clues"

    private var session: URLSession
    private var dataTask: URLSessionDataTask?

    static let shared = Networking()

    enum Error: Swift.Error {
        case invalidURL
        case noData
    }

    init() {
        session = URLSession.shared
    }

    func getRandomCategory(completion: @escaping DataCompletionBlock) {
        request(baseURL + random, completion: completion)
    }

    func getAllClues(in category: Int, completion: @escaping DataCompletionBlock) {
        request(baseURL + clues + "?category=\(category)", completion: completion)
    }

    func request(_ urlString: String, completion: @escaping DataCompletionBlock) {
        if let dataTask = dataTask {
            dataTask.cancel()
        }

        guard let url = URL(string: urlString) else { fatalError() }

        print(url)

        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let data = data, error == nil else {
                print("\(error!.localizedDescription)")
                return
            }

            completion(data)
        })
        dataTask!.resume()
    }
}
