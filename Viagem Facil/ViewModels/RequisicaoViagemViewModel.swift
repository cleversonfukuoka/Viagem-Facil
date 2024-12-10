//
//  EnderecoViewModel.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation
import Combine

class RequisicaoViagemViewModel: ObservableObject {
    @Published var enderecos: [String] = []
    @Published var errorMessage: String?

    private let service = EnderecoService()
    
    func searchAddress(query: String) {
        service.fetchAddresses(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let listaEnderecos):
                    self?.enderecos = listaEnderecos.map {
                        endereco in
                        "\(endereco.rua), \(endereco.cidade), \(endereco.estado), \(endereco.pais)"
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
