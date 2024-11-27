//
//  Pantalla_De_Inico .swift
//  ProyectoFinal
//
//  Created by alumno on 11/6/24.
//

import Foundation

import UIKit

class Pantalla_De_Inicio: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Acción conectada al botón
    @IBAction func goToNextScreen(_ sender: UIButton) {
        // Usamos el Storyboard ID para instanciar el SecondViewController
        if let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SegundaPantallaPrincipal") {
            // Si tenemos un UINavigationController, usamos push para navegar
            self.navigationController?.pushViewController(secondVC, animated: true)
        } else {
            print("No se pudo encontrar el ViewController con el Storyboard ID 'SegundaPantallaPrincipal'")
        }
    }
}

