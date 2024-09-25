//
//  ViewController.swift
//  boceto_1
//
//  Created by alumno on 9/20/24.
//

import UIKit

class ViewController: UIViewController {
    var cita_para_enviar: Cita = Cita(quien_lo_dijo: "kyrbo", que_dijo: "poyo")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBSegueAction func al_abrir_pantalla_citas(_ coder: NSCoder) -> ControladorPantallaCita? {
        return ControladorPantallaCita(cita_para_cita: cita_para_enviar, coder: coder)
    }
    
}

