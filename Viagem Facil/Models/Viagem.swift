//
//  Viagem.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 10/12/24.
//

import Foundation

struct Viagem: Codable {
    var id: String
    let origem: Coordenadas
    let destino: Coordenadas
    let distancia: Double
    let duracao: String
    let opcoes: [Motorista]
}
