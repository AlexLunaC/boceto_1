//
//  ControladorPantallaDelPost.swift
//  boceto_2_CellView
//
//  Created by alumno on 10/14/24.
//

import Foundation

import UIKit

class ControladorPantallaDelPost: UIViewController, UICollectionViewDataSource  {
    private let identificador_de_celda = "CeldaComentario"
    
    let proveedor_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    @IBOutlet weak var titulo_de_publicacion: UILabel!
    @IBOutlet weak var nombre_de_usuario: UILabel!
    @IBOutlet weak var cuerpo_de_publicacion: UILabel!
    @IBOutlet weak var seccion_comentarios: UICollectionView!

    
    public var id_publicacion: Int?
    
    private var publicacion: Publicacion?
    private var usuario: Usuario?
    private var lista_comentarios: [Comentario] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        
        let controlador_de_navegacion = self.navigationController as? mod_navegador_principal
        controlador_de_navegacion?.activar_navigation_bar(actviar: true)
        
        seccion_comentarios.dataSource = self
        
        realizar_descarga_de_informacion()
    }
    
    func realizar_descarga_de_informacion(){
        if self.publicacion == nil {
            proveedor_publicaciones.obtener_publicacion(id: self.id_publicacion ?? -1, que_hacer_al_recibir: {
                [weak self] (publicacion) in self?.publicacion = publicacion
                DispatchQueue.main.async {
                    self?.dibujar_publicacion()
                    self?.realizar_descarga_de_informacion()
                }
            })
        }
        
        else if self.publicacion != nil {
            proveedor_publicaciones.obtener_usuario(id: publicacion!.userId, que_hacer_al_recibir: {
                [weak self] (usuario) in self?.usuario = usuario
                DispatchQueue.main.async {
                    self?.dibujar_usuario()
                }
            })
            
            proveedor_publicaciones.obtener_comentarios_en_publicacion(id: publicacion!.id, que_hacer_al_recibir: {
                [weak self] (comentarios_descargados) in self?.lista_comentarios = comentarios_descargados
                DispatchQueue.main.async {
                    self?.seccion_comentarios.reloadData()
                }
            })
        }
        
        
        
    }
    
    func dibujar_publicacion(){
        guard let publicacion_actual = self.publicacion else {
            return
        }
        
        titulo_de_publicacion.text = publicacion_actual.title
        cuerpo_de_publicacion.text = publicacion_actual.body
        
    }
    
    func dibujar_usuario(){
        guard let usuario_actual = self.usuario else {
            return
        }
        
        nombre_de_usuario.text = usuario_actual.username
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista_comentarios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Aqui denberia hacer algo")
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: identificador_de_celda, for: indexPath)
    
        // Configure the cell
        celda.tintColor = UIColor.green
  
        // print(self.lista_de_publicaciones)
        
        return celda
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
