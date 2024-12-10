//
//  Untitled.swift
//  Viagem Facil
//
//  Created by Cleverson Fukuoka on 09/12/24.
//
import Foundation

struct EnderecoResponse: Decodable {
    let resultados: [EnderecoWrapper]
}

struct EnderecoWrapper: Decodable {
    let endereco: Endereco
}

struct Endereco: Decodable {
    let rua: String
    let cidade: String
    let estado: String
    let pais: String
    
    enum CodingKeys: String, CodingKey {
            case rua = "addressLine"
            case cidade = "municipality"
            case estado = "countrySubdivision"
            case pais = "country"
        }
}


