//
//  MediaQuery.swift
//  HalfTunes
//
//  Created by Islombek Hasanov on 7/26/20.
//  Copyright © 2020 raywenderlich. All rights reserved.
//

import Foundation
import Combine

class MediaQuery: ObservableObject {
    @Published var itunesQuery = ""
    @Published var searchResults: [MusicItem] = []

    var subscriptions: Set<AnyCancellable> = []
    var dataTask: URLSessionDataTask?

    init() {
        queryUsingCombine()
    }

    func getQueryPublisher() -> AnyPublisher<URL, Never> {
        $itunesQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap({ query in
                "https://itunes.apple.com/search?media=music&entity=song&term=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            })
            .compactMap({ searchURLString in
                URL(string: searchURLString)
            })
            .eraseToAnyPublisher()
    }

    func queryUsingCombine() {
        getQueryPublisher()
            .flatMap(fetchMusicCombineWay)
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchResults, on: self)
            .store(in: &subscriptions)
    }

    func queryUsualWay() {
        getQueryPublisher().sink { queryURL in
            if let dataTask = self.dataTask { dataTask.cancel() }
            self.dataTask = self.fetchMusicUsualWay(for: queryURL)
            self.dataTask!.resume()
        }
            .store(in: &subscriptions)
    }

    func fetchMusicUsualWay(for url: URL) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let mediaResponse = try JSONDecoder().decode(MediaResponse.self, from: data)
                    self.searchResults = mediaResponse.results
                } catch {
                    print(error)
                }
            }
        }
    }

    func fetchMusicCombineWay(for url: URL) -> AnyPublisher<[MusicItem], Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MediaResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
