//
//  StackoverflowService.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 04/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import Combine

final class StackoverflowService {
    private var cancelBag: Set<AnyCancellable> = []
    
    func loadQuestions() -> AnyPublisher<[QuestionDTO], Error> {
        let url = URL(string: "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PostsDTO<QuestionDTO>.self, decoder: JSONDecoder())
            .tryMap { posts in
                posts.items
            }
            .eraseToAnyPublisher()
    }
    
    deinit {
        cancelBag.forEach { $0.cancel() }
    }
}
