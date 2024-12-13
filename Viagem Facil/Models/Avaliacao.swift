//
//  Avaliacao.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 10/12/24.
//

import Foundation

struct Avaliacao: Decodable {
    let pontuacao: Int
    let comentario: String
    
    enum CodingKeys: String, CodingKey {
        case pontuacao = "rating"
        case comentario = "comment"
    }
}
