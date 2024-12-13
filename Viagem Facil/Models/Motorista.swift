//
//  Motorista.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation

struct Motorista: Decodable, Identifiable {
    let id: Int
    let nome: String
    let descricao: String
    let veiculo: String
    let avaliacao: Avaliacao
    let valor: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nome = "name"
        case descricao = "description"
        case veiculo = "vehicle"
        case avaliacao = "review"
        case valor = "value"
    }
}
