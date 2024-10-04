//
//  ViewController.swift
//  boceto_1
//
//  Created by alumno on 9/20/24.
//

import UIKit

class ViewController: UIViewController {
    var cita_para_enviar: Cita = Cita(quien_lo_dijo: "kyrbo", que_dijo: "poyo")
    var citas_disponibles: GeneradorDeCitas = GeneradorDeCitas()
    var numero_aleatorio: Int = Int.random(in: 0...25)
    
    @IBOutlet weak var labelcito: UILabel!

    override func viewDidLoad() {
        citas_disponibles.generar_citas_falsas()
            
                super.viewDidLoad()
                
                actualizar_cantidad()
    }
    
    func actualizar_cantidad(){
            labelcito.text = String(citas_disponibles.citas_creadas.count)
        }

    @IBSegueAction func al_abrir_pantalla_citas(_ coder: NSCoder) -> ControladorPantallaCita? {
        return ControladorPantallaCita(cita_para_cita: citas_disponibles.obtener_cita_aleatoria(), coder: coder)
    }
    
    /*@IBAction func al_pulsar_boton(_ sender: UIButton){
        
    }*/
    
    @IBAction func volver_a_pantalla_inicio(segue: UIStoryboardSegue) {
        if let pantalla_agregar_citas = segue.source as? ControladorPantallaAgregarCitas {
            if let citaCreada = pantalla_agregar_citas.cita_creada {
                citas_disponibles.agregar_cita(citaCreada)
            } else {
                print("aqui no hay nada mi pa")
            }
        }
    
        
        //let pantalla_citas = segue.source as? ControladorPantallaCita
        //print(pantalla_citas?.cita_actual.texto)
        
        /*if let pantalla_citas = segue.source as? ControladorPantallaCita{
            citas_disponibles.agregar_cita(pantalla_citas.cita_actual.texto, quien_lo_dijo: pantalla_citas.cita_actual.nombre)
        }*/
        
        actualizar_cantidad()
        
    }
    
}


