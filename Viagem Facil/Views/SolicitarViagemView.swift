import SwiftUI

struct SolicitarViagemView: View {
    @State private var usuarioId = ""
    @State private var origem = ""
    @State private var destino = ""
    @State private var mensagemErro = ""
    @State private var mostrandoCarregamento = false
    @State private var SolicitacaoViagemEstimada: SolicitacaoViagem? = nil
    @State private var mostrarOpcoes = false // Indicador de navegação
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Solicitação de Viagem")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                VStack(spacing: 16) {
                    TextField("ID do Usuário", text: $usuarioId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Endereço de Origem", text: $origem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Endereço de Destino", text: $destino)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                Button(action: {
                    Task {
                        await vm.postEstimarSolicitacaoViagem(usuarioId: usuarioId, origem: origem, destino: destino)
                    }
                }) {
                    Text("Estimar Viagem")
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
    SolicitarViagemView()
}

