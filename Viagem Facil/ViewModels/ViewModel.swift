//
//  EnderecoViewModel.swift
//  SolicitacaoCorrida Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import Foundation

class ViewModel: ObservableObject {
    enum FetchStatus {
        case notStarted
        case notHistory
        case fetching
        case successSolicitacaoViagem
        case successHistorico
        case failed(error: Error)
    }
    
    @Published private(set) var status: FetchStatus = .notStarted
    
    @Published var motoristas: [Motorista] = []
    @Published var SolicitacaoViagemConfirmada = false
    @Published var motoristaEscolhido: Motorista?
    
    private let fetcher = ViagemService()
    private(set) var SolicitacaoViagem: SolicitacaoViagem?
    private(set) var listaViagens: [Historico] = []
    
    init() {}
    
    func postEstimarSolicitacaoViagem(usuarioId: String, origem: String, destino: String) async {
        status = .fetching
        do {
            let SolicitacaoViagemEstimada = try await fetcher.estimarSolicitacaoViagemAsync(
                usuarioId: usuarioId,
                origem: origem,
                destino: destino
            )
            SolicitacaoViagem = SolicitacaoViagemEstimada
            status = .successSolicitacaoViagem
        } catch {
            status = .failed(error: error)
        }
    }
    
    func fetchViagens(usuarioId: String, motoristaId: String?) async {
        status = .fetching
        
        do {
            let historico = try await fetcher.listarHistoricoViagemPorUsuarioAsync(usuarioId: usuarioId, motoristaId: motoristaId)
            listaViagens = historico
            status = .successHistorico
            
        } catch {
            status = .failed(error: error)
        }
    }
    
    func confirmarSolicitacaoViagem(com motorista: Motorista) {
        motoristaEscolhido = motorista
        enviarConfirmacaoParaServidor(motorista: motorista)
        SolicitacaoViagemConfirmada = true
    }
    
    private func enviarConfirmacaoParaServidor(motorista: Motorista) {
        print("Confirmando Solicitacao Viagem com o motorista \(motorista.nome)...")
        // Chamada real à API pode ser implementada aqui
    }
}
