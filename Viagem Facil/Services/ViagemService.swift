
import Foundation

struct ViagemService {
    private enum ViagemError: Error {
        case badResponse
    }
    
    private let baseURL = "https://xd5zl5kk2yltomvw5fb37y3bm40vsyrx.lambda-url.sa-east-1.on.aws"

    func estimarViagemAsync(id: String, origem: String, destino: String) async throws -> Viagem {
        let estimarViagemURL = baseURL.appending(path: "ride/estimate")
        
        // Criando o corpo da requisição como um dicionário
        let body: [String: Any] = [
            "customer_id": id,
            "origin": origem,
            "destination": destino
        ]
        
        // Convertendo o corpo para JSON
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: estimarViagemURL)
        request.httpMethod = "POST"  // Definindo o método como POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")  // Definindo o tipo do conteúdo
        request.httpBody = bodyData  // Adicionando o corpo na requisição
        
        // Realizando a requisição
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decodificando a resposta em um objeto da classe Viagem
        let estimativa = try JSONDecoder().decode(Viagem.self, from: data)
        
        return estimativa
    }

    
    func confirmarViagemAsync(id: String, origem: String, destino: String, distancia: Double, duracao: String, motorista: Motorista, valor: Double) async throws -> Viagem {
        
        let confirmarViagemURL = baseURL.appending(path: "ride/confirm")
        
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
        
        var request = URLRequest(url: confirmarViagemURL)
        request.httpMethod = "PATCH"  // Definindo o método como PATCH
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")  // Definindo o tipo do conteúdo
        request.httpBody = bodyData  // Adicionando o corpo na requisição
        
        // Realizando a requisição
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verificando a resposta da requisição
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decodificando a resposta em um objeto da classe Viagem
        let viagem = try JSONDecoder().decode(Viagem.self, from: data)
        
        return viagem
    }

    
    func listarViagemPorUsuarioAsync(usuarioId: String, motoristaId: String) async throws -> [Viagem] {
        let listarViagemURL = baseURL.appending(path: "ride/")
        let fetchURL = listarViagemURL.appending(queryItems: [URLQueryItem(name:"customer_id", value: usuarioId), URLQueryItem(name: "driver_id", value: motoristaId)])
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let listaviagem = try JSONDecoder().decode([Viagem].self, from: data)
        return listaviagem
    }
}

