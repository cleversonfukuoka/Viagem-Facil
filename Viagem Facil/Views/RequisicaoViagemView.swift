//
//  View.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 08/12/24.
//

import SwiftUI


struct RequisicaoViagemView: View {
    @State private var usuarioId = ""
    @State private var origem = ""
    @State private var destino = ""
    @State private var mensagemErro = ""
    @State private var mostrandoCarregamento = false
    @State private var viagemEstimada: Viagem? = nil
    let rvm = RequisicaoViagemViewModel()

    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Solicitação de Viagem")
                    .font(.largeTitle)
                    .bold()
                
                TextField("ID do Usuário", text: $usuarioId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                
                TextField("Endereço de Origem", text: $origem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                
                TextField("Endereço de Destino", text: $destino)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                
                if mostrandoCarregamento {
                    ProgressView("Carregando...")
                }
                
                Button("Estimar Viagem") {
                    Task {
                        await solicitarViagem()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(mostrandoCarregamento)
                
                if !mensagemErro.isEmpty {
                    Text(mensagemErro)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
                
                // Usando NavigationLink para navegação para a próxima tela
                NavigationLink(destination: OpcoesViagemView(viagem: viagemEstimada), isActive: .constant(viagemEstimada != nil)) {
                    EmptyView()  // Não precisa de conteúdo no link, pois ele será ativado programaticamente
                }
            }
            .padding()
        }
    }
    
    func solicitarViagem() async {
        guard !usuarioId.isEmpty, !origem.isEmpty, !destino.isEmpty else {
            mensagemErro = "Por favor, preencha todos os campos."
            return
        }
        
        mostrandoCarregamento = true
        mensagemErro = ""
        
        
        await rvm.postEstimarViagem(
                usuarioId: usuarioId,
                origem: origem,
                destino: destino
            )
        print("Viagem estimada: \(rvm.viagem)")
        viagemEstimada = rvm.viagem
        
        mostrandoCarregamento = false
    }
}

#Preview {
    RequisicaoViagemView()
}


