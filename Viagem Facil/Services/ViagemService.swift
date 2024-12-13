//
//  APIService.swift
//  SolicitacaoCorrida Facil
//
//  Created by Cleverson Fukuoka on 10/12/24.
//


import Foundation

struct ViagemService {
    private enum ViagemError: Error {
        case badResponse
        case decodingError
    }
    
    private let baseURL = URL(filePath: "https://xd5zl5kk2yltomvw5fb37y3bm40vsyrx.lambda-url.sa-east-1.on.aws")!

    func estimarSolicitacaoViagemAsync(usuarioId: String, origem: String, destino: String) async throws -> SolicitacaoViagem {
        let estimarSolicitacaoViagemURL = baseURL.appending(path: "ride/estimate")
        
        // Criando o corpo da requisição como um dicionário
        let body: [String: Any] = [
            "customer_id": usuarioId,
            "origin": origem,
            "destination": destino
        ]
        
        // Convertendo o corpo para JSON
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            throw ViagemError.decodingError
        }
        
        var request = URLRequest(url: estimarSolicitacaoViagemURL)
        request.httpMethod = "POST"  // Definindo o método como POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")  // Definindo o tipo do conteúdo
        request.httpBody = bodyData  // Adicionando o corpo na requisição
        
        // Realizando a requisição
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ViagemError.badResponse
        }
                
        // Decodificando a resposta da API
        do {
            if let responseDataString = String(data: data, encoding: .utf8) {
                print("Resposta da API: \(responseDataString)")
            }
            let SolicitacaoViagem = try JSONDecoder().decode(SolicitacaoViagem.self, from: data)
            return SolicitacaoViagem
        } catch let DecodingError.dataCorrupted(context) {
            print("Dados corrompidos: \(context.debugDescription)")
            throw ViagemError.decodingError
        } catch let DecodingError.keyNotFound(key, context) {
            print("Chave não encontrada: \(key.stringValue) no \(context.debugDescription)")
            throw ViagemError.decodingError
        } catch let DecodingError.typeMismatch(type, context) {
            print("Tipo incompatível: \(type) no \(context.debugDescription)")
            throw ViagemError.decodingError
        } catch let DecodingError.valueNotFound(value, context) {
            print("Valor não encontrado: \(value) no \(context.debugDescription)")
            throw ViagemError.decodingError
        } catch {
            print("Erro desconhecido: \(error.localizedDescription)")
            throw ViagemError.decodingError
        }
    }

    
    func confirmarSolicitacaoViagemAsync(id: String, origem: String, destino: String, distancia: Double, duracao: String, motorista: Motorista, valor: Double) async throws -> SolicitacaoViagem {
        
        let confirmarSolicitacaoViagemURL = baseURL.appending(path: "ride/confirm")
        
        // Criando o corpo da requisição com os parâmetros para atualização
        let body: [String: Any] = [
            "customer_id": id,
            "origin": origem,
            "destination": destino,
            "distance": distancia,
            "duration": duracao,
            "driver_id": motorista.id,
            "price": valor
        ]
        
        // Convertendo o corpo para JSON
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: confirmarSolicitacaoViagemURL)
        request.httpMethod = "PATCH"  // Definindo o método como PATCH
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")  // Definindo o tipo do conteúdo
        request.httpBody = bodyData  // Adicionando o corpo na requisição
        
        // Realizando a requisição
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verificando a resposta da requisição
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ViagemError.badResponse
        }
        
        // Decodificando a resposta em um objeto da classe SolicitacaoViagem
        let SolicitacaoViagem = try JSONDecoder().decode(SolicitacaoViagem.self, from: data)
        
        return SolicitacaoViagem
    }

    
    func listarHistoricoViagemPorUsuarioAsync(usuarioId: String, motoristaId: String?) async throws -> [Historico] {
        let listarHistoricoViagemURL = baseURL.appending(path: "ride/CT01")
        
        // Configurando os parâmetros de consulta
        var queryItems: [URLQueryItem] = []
        
        if let motoristaId = motoristaId {
            queryItems.append(URLQueryItem(name: "driver_id", value: motoristaId))
        }
        
        var urlComponents = URLComponents(url: listarHistoricoViagemURL, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = queryItems
                guard let fetchURL = urlComponents.url else {
                    throw URLError(.badURL)
                }
                
                let (data, response) = try await URLSession.shared.data(from: fetchURL)

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }

                let listaHistoricoSolicitacaoViagem = try JSONDecoder().decode([Historico].self, from: data)
                return listaHistoricoSolicitacaoViagem
    }
}

