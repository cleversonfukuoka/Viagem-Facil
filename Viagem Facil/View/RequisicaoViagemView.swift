//
//  View.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 08/12/24.
//

import SwiftUI

struct RequisicaoViagemView: View {
    @State private var customerId = ""
    @State private var origin = ""
    @State private var destination = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Solicitação de Viagem")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Form {
                    Section(header: Text("Informações do Usuário")) {
                        TextField("ID do Usuário", text: $customerId)
                            .keyboardType(.default)
                            .autocapitalization(.none)
                    }
                    
                    Section(header: Text("Endereços")) {
                        TextField("Origem", text: $origin)
                            .keyboardType(.default)
                        
                        TextField("Destino", text: $destination)
                            .keyboardType(.default)
                    }
                }
                
                Button(action: {
                    enviarSolicitacao()
                }) {
                    Text("Estimar Viagem")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .disabled(isLoading || customerId.isEmpty || origin.isEmpty || destination.isEmpty)
                
                Spacer()
            }
            .padding()
            //.navigationTitle("Solicitar Viagem")
        }
    }
    
    private func enviarSolicitacao() {
        isLoading = true
        // Aqui será feita a chamada para a API
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            print("Solicitação enviada!")
        }
    }
}

#Preview {
    RideRequestView()
}


