//
//  View.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 08/12/24.
//

import SwiftUI

struct RequisicaoViagemView: View {
    @State private var viewModel = RequisicaoViagemViewModel()
    @State private var customerId = ""
    @State private var origem = ""
    @State private var destino = ""
    @State private var possiveisEnderecos: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Solicitação de Viagem")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            
            Text("ID do Usuário:")
                .font(.headline)
            TextField("Digite seu ID", text: $customerId)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 10)
                
            Text("Origem:")
                .font(.headline)
            TextField("Endereço de Origem", text: $origem)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 10)
                .onChange(of:origem){
                    filtrarEnderecos(texto: origem)
            }
            
            // Lista de sugestões
            if !possiveisEnderecos.isEmpty {
                List(possiveisEnderecos, id: \.self) { address in
                    Text(address)
                        .onTapGesture {
                            origem = address
                            possiveisEnderecos.removeAll()
                        }
                    }
                    .frame(maxHeight: 150)
            }
                
            Text("Destino:")
                .font(.headline)
            
            TextField("Endereço de Destino", text: $destino)
                .textFieldStyle(.roundedBorder)
                .onChange(of:destino){
                    filtrarEnderecos(texto:destino)
            }
            
            
            Button(action: {
                enviarSolicitacao()
            }) {
                Text("Solicitar Viagem")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .disabled(customerId.isEmpty || origem.isEmpty || destino.isEmpty)
            
            Spacer()  // Preenche o espaço restante
        }
        .padding()
        .onReceive(viewModel.$enderecos) {
            enderecos in possiveisEnderecos = enderecos
        }
    }
    
    private func enviarSolicitacao() {
        print("Solicitação enviada!")
    }
    
    private func filtrarEnderecos(texto: String) {
            if texto.isEmpty {
                possiveisEnderecos.removeAll()
            } else {
                viewModel.searchAddress(query: texto)
                }
    }
}

#Preview {
    RequisicaoViagemView()
}


