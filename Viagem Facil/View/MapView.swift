//
//  MapView.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -23.5505, longitude: -46.6333),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var body: some View {
        Map(position: $cameraPosition) {
            // Adiciona o ponto A
            Marker("Ponto A", coordinate: CLLocationCoordinate2D(latitude: -23.5505, longitude: -46.6333))
            
            // Adiciona o ponto B
            Marker("Ponto B", coordinate: CLLocationCoordinate2D(latitude: -23.5520, longitude: -46.6350))
        }
        .mapStyle(.standard) // Define o estilo do mapa (padrão, satélite ou híbrido)
        .frame(height: 300) // Ajuste de tamanho do mapa
        .cornerRadius(10)   // Bordas arredondadas
        .padding()
    }
}
#Preview {
    MapView()
}
