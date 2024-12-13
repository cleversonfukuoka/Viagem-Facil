import SwiftUI

struct OpcoesViagemView: View {
    let SolicitacaoViagem: SolicitacaoViagem
    let viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // Mapa Estático no Topo
                MapView()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                // Lista de Motoristas Rolável
                ScrollView(.vertical) {
                    VStack(spacing: 16) {
                        ForEach(SolicitacaoViagem.opcoes, id: \ .id) { motorista in
                            MotoristaCardView(motorista: motorista) {
                                confirmarSolicitacaoViagem(motorista: motorista)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 16)
            .navigationTitle("Opções de Viagem")
        }
    }
    
    private func confirmarSolicitacaoViagem(motorista: Motorista) {
        viewModel.confirmarSolicitacaoViagem(com: motorista)
    }
}


