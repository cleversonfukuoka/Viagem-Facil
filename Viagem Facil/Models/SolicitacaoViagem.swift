//
//  SolicitacaoCorrida.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 10/12/24.
//

import Foundation

struct SolicitacaoViagem: Decodable {
    let origem: Coordenada
    let destino: Coordenada
    let distancia: Double
    let duracao: Double
    let opcoes: [Motorista]
    
    enum CodingKeys: String, CodingKey {
        case origem = "origin"
        case destino = "destination"
        case distancia = "distance"
        case duracao = "duration"
        case opcoes = "options"
        
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            origem = try container.decode(Coordenada.self, forKey: .origem)
            destino = try container.decode(Coordenada.self, forKey: .destino)
            distancia = try container.decode(Double.self, forKey: .distancia)
            duracao = try container.decode(Double.self, forKey: .duracao)
            
            // Decodifica `opcoes` como array ou objeto único
            if let opcoesArray = try? container.decode([Motorista].self, forKey: .opcoes) {
                opcoes = opcoesArray
            } else if let singleOpcao = try? container.decode(Motorista.self, forKey: .opcoes) {
                opcoes = [singleOpcao]
            } else {
                opcoes = []
            }
    }
}
