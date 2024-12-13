import SwiftUI

struct SolicitarHistoricoView: View {
    @State private var usuarioId = ""
    @State private var motoristaId = ""
    @State private var mostrandoCarregamento = false
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Solicitação de Histórico")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                VStack(spacing: 16) {
                    TextField("ID do Usuário", text: $usuarioId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("ID do Motorista", text: $motoristaId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                Button(action: {
                    Task {
                        await vm.fetchViagens(usuarioId: "CT01", motoristaId: nil)
                    }
                }) {
                    Text("Solicitar Histórico")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                switch vm.status {
                case .notStarted:
                    EmptyView()
                case .notHistory:
                    EmptyView()
                case .successSolicitacaoViagem:
                    OpcoesViagemView(SolicitacaoViagem: vm.SolicitacaoViagem!)
                case .successHistorico:
                    ListarHistoricoViagemView(listaViagens: vm.listaViagens)
                case .fetching:
                    ProgressView("Carregando...")
                        .font(.headline)
                        .padding()
                case .failed(let error):
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
        }
    }
}

#Preview {
    SolicitarHistoricoView()
}

