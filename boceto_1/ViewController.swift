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

    override func viewDidLoad() {
        citas_disponibles.generar_citas_falsas()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let valor = Int.random(in: 1...100)
        Double.random(in: 0...100)
    }

    @IBSegueAction func al_abrir_pantalla_citas(_ coder: NSCoder) -> ControladorPantallaCita? {
        return ControladorPantallaCita(cita_para_cita: cita_para_enviar, coder: coder)
    }
    
}

