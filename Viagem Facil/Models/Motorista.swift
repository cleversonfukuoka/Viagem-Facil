//
//  Motorista.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation

struct Motorista: Identifiable {
    let id = UUID()
    let nome: String
    let descricao: String
    let veiculo: String
    let avaliacao: Double
    let valor: Double
}
