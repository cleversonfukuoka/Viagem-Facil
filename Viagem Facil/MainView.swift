//
//  MainView.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 08/12/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            RequisicaoViagemView()
                .tabItem {
                    Label("Solicitar", systemImage: "car.fill")
                }
                .tag(0)
            
            HistoricoViagemView()//RideHistoryView()
                .tabItem {
                    Label("Histórico", systemImage: "clock.fill")
                }
                .tag(1)
        }
        .accentColor(.black) // Cor de destaque
    }
}

#Preview {
    MainView()
}
