//
//  Viagem.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 10/12/24.
//

import Foundation

struct Viagem: Decodable, Identifiable{
    let id: Int
    let date: String
    let origem: String
    let destino: String
    let distancia: Double
    let duracao: String
    let motorista: Motorista
    let valor: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case origem = "origin"
        case destino = "destination"
        case distancia = "distance"
        case duracao = "duration"
        case motorista = "driver"
        case valor = "value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        date = try container.decode(String.self, forKey: .date)
        origem = try container.decode(String.self, forKey: .origem)
        destino = try container.decode(String.self, forKey: .destino)
        distancia = try container.decode(Double.self, forKey: .distancia)
        duracao = try container.decode(String.self, forKey: .duracao)
        motorista = try container.decode(Motorista.self, forKey: .motorista)
        valor = try container.decode(Double.self, forKey: .valor)
    }
}
