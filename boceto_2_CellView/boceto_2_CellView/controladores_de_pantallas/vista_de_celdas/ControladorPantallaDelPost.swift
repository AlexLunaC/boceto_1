//
//  ControladorPantallaDelPost.swift
//  boceto_2_CellView
//
//  Created by alumno on 10/14/24.
//

import Foundation

import UIKit

class ControladorPantallaDelPost: UIViewController {
    
    let proveedor_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    public var id_publicacion: Int?
    
    private var publicacion: Publicacion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola mundo")
        
        // Do any additional setup after loading the view.
        
        
        let controlador_de_navegacion = self.navigationController as? mod_navegador_principal
        controlador_de_navegacion?.activar_navigation_bar(actviar: true)
        
    realizar_descarga_de_informacion()
    }
    
    func realizar_descarga_de_informacion(){
        proveedor_publicaciones.obtener_publicaicones(id: self.id_publicacion ?? -1, que_hacer_al_recibir: {
            [weak self] (publicaion) in self?.publicacion = publicacion DispatchQueue.main.async {
                self?.dibujar_publicacion()
            }
        })
    }
    func dibujar_publicacion(){
        print(publicacion?.body)
    }
}
