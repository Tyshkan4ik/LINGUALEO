//
//  NetworkService.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import Foundation

struct NetworkService {
    
    func getPlayers(completion: @escaping (Result<PlayersModelResponse, FetchError>) -> Void) {
        guard let response: PlayersModelResponse = loadJSON(file: "PlayersJSON") else {
            completion(.failure(.invalidateResponse))
            return
        }
        
        completion(.success(response))
    }
    
    private func loadJSON<T: Decodable>(file: String) -> T? {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return jsonData
        } catch {
            return nil
        }
    }
    
    enum FetchError: Error {
        case invalidateResponse
    }
}
