//
//  ControladorPantallaCita.swift
//  boceto_1
//
//  Created by alumno on 9/23/24.
//

import Foundation
import UIKit

class ControladorPantallaCita: UIViewController {
    
    @IBOutlet var nombre_de_quien_lo_dijo: UILabel!
    @IBOutlet var que_dijo_muro_texto: UILabel!
    
  
    var cita_actual: Cita
    required init?(coder: NSCoder){
        
        self.cita_actual = Cita(quien_lo_dijo: "desarrollador", que_dijo: "tenemos un problema reportalo por una galleta")
       
        super.init(coder:  coder)
        print("error: de ha cargado el default de INIT")
    }
    
    init?(cita_para_cita:Cita, coder: NSCoder){
        self.cita_actual = cita_para_cita
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inicializar_pantalla()
    }
    
    func inicializar_pantalla(){
        nombre_de_quien_lo_dijo.text = cita_actual.nombre
        
        que_dijo_muro_texto.text = cita_actual.texto
    }

}
