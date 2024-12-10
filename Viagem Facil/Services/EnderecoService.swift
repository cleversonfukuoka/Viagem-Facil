//
//  AddressService.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation

class EnderecoService {
    private let baseURL = "https://atlas.microsoft.com/search/address"

    /// Faz a busca de endereços com base em uma palavra-chave.
    func fetchAddresses(query: String, completion: @escaping (Result<[Endereco], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)json?api-version=1.0&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            completion(.failure(NSError(domain: "URL inválida", code: 400, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Resposta inválida do servidor", code: 500, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Dados inválidos", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(EnderecoResponse.self, from: data)
                let enderecos = decodedResponse.results.map { $0.endereco }
                completion(.success(enderecos))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
