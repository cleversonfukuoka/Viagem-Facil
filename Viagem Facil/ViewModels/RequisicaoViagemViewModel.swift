//
//  EnderecoViewModel.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation

@Observable
class RequisicaoViagemViewModel {
    
    private let fetcher = ViagemService()
    
    var viagem: Viagem
    
    init() {
        
    }
    
    func postEstimarViagem(usuarioId: String, origem: String, destino: String) async {
        viagem = await fetcher.estimarViagemAsync(
            usuarioId: usuarioId,
            origem: origem,
            destino: destino
        )
    }
}
