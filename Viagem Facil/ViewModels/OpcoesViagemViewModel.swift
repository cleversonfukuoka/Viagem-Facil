//
//  OpcoesViagemViewModel.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation

class OpcoesDeViagemViewModel: ObservableObject {
    @Published var motoristas: [Motorista] = []
    @Published var viagemConfirmada = false
    
    // Simula a requisição para buscar motoristas
    func buscarMotoristas() {
        motoristas = [
            Motorista(nome: "João", descricao: "Motorista Experiente", veiculo: "Toyota Corolla", avaliacao: 4.8, valor: 35.00),
            Motorista(nome: "Maria", descricao: "Rápida e segura", veiculo: "Honda Civic", avaliacao: 4.7, valor: 33.50)
        ]
    }
    
    // Simula a confirmação da viagem
    func confirmarViagem() {
        // Lógica de requisição para API
        viagemConfirmada = true
        print("Viagem Confirmada!")
    }
}
