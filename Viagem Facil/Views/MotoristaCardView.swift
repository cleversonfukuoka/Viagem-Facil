//
//  MotoristaCardView.swift
//  SolicitacaoCorrida Facil
//
//  Created by Cleverson Fukuoka on 12/12/24.
//
import SwiftUI

struct MotoristaCardView: View {
    let motorista: Motorista
    let confirmarSolicitacaoViagem: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(motorista.nome)
                .font(.headline)
            
            Text(motorista.descricao)
                .font(.subheadline)
            
            Text("Veículo: \(motorista.veiculo)")
                .font(.subheadline)
            
            Text("Avaliação: \(motorista.avaliacao.pontuacao) ⭐")
                .font(.subheadline)
            
            Text("Valor: R$ \(motorista.valor, specifier: "%.2f")")
                .font(.subheadline)
            
            Button(action: confirmarSolicitacaoViagem) {
                Text("Escolher")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

