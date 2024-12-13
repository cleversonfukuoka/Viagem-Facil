//  Historico.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 12/12/24.
//

import Foundation

struct Historico: Decodable, Identifiable {
    let id: UUID = UUID()
    let usuarioId: String
    let viagens: [Viagem]

    enum CodingKeys: String, CodingKey {
        case usuarioId = "customer_id"
        case viagens = "rides"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        usuarioId = try container.decode(String.self, forKey: .usuarioId)
        
        // Decodifica `viagens` como array ou objeto único
        //if let viagensArray = try? container.decode([Viagem].self, forKey: .viagens) {
        //    viagens = viagensArray
        //} else if let singleViagem = try? container.decode(Viagem.self, forKey: .viagens) {
        //    viagens = [singleViagem]
        //} else {
        //    viagens = []
        //}
        viagens = try container.decode([Viagem].self, forKey: .viagens)
    }
}
