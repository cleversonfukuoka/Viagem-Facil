import SwiftUI

struct ListarHistoricoViagemView: View {
    let listaViagens: [Historico]
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Histórico de Viagens")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                    .padding(.horizontal)
                
                ScrollView(.vertical) {
                    VStack(spacing: 16) {
                        ForEach(listaViagens) { historico in
                            viagensListView(historico: historico)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private func viagensListView(historico: Historico) -> some View {
            VStack(spacing: 16) {
                ForEach(historico.viagens) { viagem in
                    HistoricoCardView(viagem: viagem)
                }
            }
        }
}
