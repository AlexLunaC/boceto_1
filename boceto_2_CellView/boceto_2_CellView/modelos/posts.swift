//
//  posts.swift
//  boceto_2_CellView
//
//  Created by alumno on 10/9/24.
//

import Foundation

struct Publicacion: Decodable{
    //Decodable: Permite convertir informacion json a un modelo de swift
    //Encodable: permite convertir un modelo de swiift a Json
    //Codable: ambas al mismo tiempo 
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
