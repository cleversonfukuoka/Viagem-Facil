//
//  OpcoesViagemView.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 08/12/24.
//

import SwiftUI

struct OpcoesViagemView: View {
    @StateObject private var viewModel = OpcoesDeViagemViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Mapa Estático
                    MapView()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // Lista de Motoristas
                    ForEach(viewModel.motoristas) { motorista in
                        MotoristaCard(motorista: motorista) {
                            viewModel.confirmarViagem()
                        }
                    }
                }
                .navigationTitle("Opções de Viagem")
                .onAppear {
                    viewModel.buscarMotoristas()
                }
                .navigationDestination(isPresented: $viewModel.viagemConfirmada) {
                    HistoricoViagemView()
                }
            }
        }
    }
}

struct MotoristaCard: View {
    let motorista: Motorista
    let confirmarViagem: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(motorista.nome)
                .font(.headline)
            
            Text(motorista.descricao)
                .font(.subheadline)
            
            Text("Veículo: \(motorista.veiculo)")
                .font(.subheadline)
            
            Text("Avaliação: \(motorista.avaliacao, specifier: "%.1f") ⭐")
                .font(.subheadline)
            
            Text("Valor: R$ \(motorista.valor, specifier: "%.2f")")
                .font(.subheadline)
            
            Button(action: confirmarViagem) {
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
        .padding(.horizontal)
    }
}

#Preview {
    OpcoesViagemView()
}

