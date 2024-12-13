//
//  HistoricoCardView.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 12/12/24.
//

import SwiftUI

struct HistoricoCardView: View {
    let viagem: Viagem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            
            Text("Data: \(viagem.date)")
                .font(.headline)
            
            Text("Valor: \(viagem.valor)")
                .font(.subheadline)
            
            Text("Origem: \(viagem.origem)")
                .font(.subheadline)
            
            Text("Destino: \(viagem.destino)")
                .font(.subheadline)
            
            Text("Distancia: \(viagem.distancia)")
                .font(.subheadline)
            
            Text("Motorista: \(viagem.motorista.nome)")
                .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

