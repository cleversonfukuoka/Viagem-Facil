//
//  MainView.swift
//  SolicitacaoCorrida Facil
//
//  Created by Cleverson Fukuoka on 08/12/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SolicitarViagemView()
                .tabItem {
                    Label("Solicitar", systemImage: "car.fill")
                }
                .tag(0)
            
            SolicitarHistoricoView()
                .tabItem {
                    Label("Histórico", systemImage: "clock.fill")
                }
                .tag(1)
        }
        .accentColor(.black)
        
    }
}

#Preview {
    MainView()
}
