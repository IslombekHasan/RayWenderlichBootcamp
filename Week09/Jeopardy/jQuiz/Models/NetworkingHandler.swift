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

class Networking: NSObject {
    public let logoURL = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
    private let baseURL = "https://jservice.io/api/"
    private let random = "random"
    private let categories = "categories"
    private let clues = "clues"

    private lazy var session: URLSession = URLSession.shared
    private var dataTask: URLSessionDataTask?

    private static var store: [String: Data] = [:]
    static let shared = Networking()

    enum Error: Swift.Error {
        case invalidURL
        case invalidData
    }

    func getFromStore(with key: String) -> Data? {
        if let data = Networking.store[key] {
            return data
        }
        return nil
    }

    func saveInStore(_ data: Data, with key: String) {
        Networking.store[key] = data
    }

    func getRandomCategory(completion: @escaping DataCompletionBlock) {
        request(baseURL + random, completion: completion)
    }

    func getAllClues(in category: Int, completion: @escaping DataCompletionBlock) {
        request(baseURL + clues + "?category=\(category)", completion: completion)
    }

    func getLogo(_ completion: @escaping DataCompletionBlock) {
        requestDownload(logoURL, completion: completion)
    }

    func request(_ urlString: String, completion: @escaping DataCompletionBlock) {
        if let dataTask = dataTask {
            dataTask.cancel()
        }

        if let data = getFromStore(with: urlString) {
            completion(data)
            return
        }

        guard let url = URL(string: urlString) else {
            print("Invalid URL:  \(logoURL)")
            return
        }

        print(url)

        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let data = data, error == nil else {
                print("\(error!.localizedDescription)")
                return
            }

            self.saveInStore(data, with: urlString)
            completion(data)
        })
        dataTask!.resume()
    }

    func requestDownload(_ urlString: String, completion: @escaping DataCompletionBlock) {

        if let data = getFromStore(with: urlString) {
            completion(data)
            return
        }

        guard let url = URL(string: urlString) else {
            print("Invalid URL:  \(logoURL)")
            return
        }

        session.downloadTask(with: url) { location, response, error in
            guard let location = location,
                let data = try? Data(contentsOf: location) else {
                    print("Something's wrong with the url/data. Error: \(String(describing: error?.localizedDescription))")
                    return
            }
            self.saveInStore(data, with: urlString)
            completion(data)
        }.resume()

    }
}
