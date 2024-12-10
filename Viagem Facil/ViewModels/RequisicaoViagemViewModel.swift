//
//  EnderecoViewModel.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//



import Foundation
import Combine

class EnderecoViewModel: ObservableObject {
    @Published var addresses: [Address] = []
    @Published var errorMessage: String?

    private let service = EnderecoService()
    
    func searchAddress(query: String) {
        service.fetchAddresses(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let addresses):
                    self?.addresses = addresses
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
