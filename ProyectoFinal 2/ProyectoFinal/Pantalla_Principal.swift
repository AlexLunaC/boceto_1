//
//  Pantalla_Principal.swift
//  ProyectoFinal
//
//  Created by alumno on 11/6/24.
//

import Foundation

import UIKit
import WebKit

class Pantalla_Principal: UIViewController {
    
    @IBOutlet weak var ImageUsed: UIImageView!
    
    @IBOutlet weak var WebVideo2: WKWebView!
    @IBOutlet weak var WebVideo: WKWebView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var ButtonMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebVideo.isHidden = false // Si no está oculto
        WebVideo2.isHidden = false
        
        loadYouTubeVideo(videoID: "U7u1Ksqp8mY?si=uC5Il_3IHE5O686M", in: WebVideo)
        loadYouTubeVideo(videoID: "90f5eEqrZG8?si=_Au1ncnv3S2AvfoU", in: WebVideo2)

    }
    
    // Acción conectada al botón
    @IBAction func goToNextScreen(_ sender: UIButton) {
        // Usamos el Storyboard ID para instanciar el SecondViewController
        if let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PantallaDelForo") {
            // Si tenemos un UINavigationController, usamos push para navegar
            self.navigationController?.pushViewController(secondVC, animated: true)
        } else {
            print("No se pudo encontrar el ViewController con el Storyboard ID 'PantallaDelForo'")
        }
    }
    
    @IBAction func ToggleMenu(_ sender: UIButton) {
        
                let isMenuHidden = menuView.isHidden

                if isMenuHidden {
           
                    menuView.isHidden = false
                    menuView.alpha = 0
                    menuView.transform = CGAffineTransform(translationX: -menuView.frame.width, y: 0)

                    UIView.animate(withDuration: 0.3, animations: {
                      
                        self.menuView.transform = .identity
                        self.menuView.alpha = 1
                    })
                } else {
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        
                        self.menuView.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
                        self.menuView.alpha = 0 // Desvanece el menú
                    }) { _ in
                        
                self.menuView.isHidden = true
            }
        }
    }
    // Método para cargar un video de YouTube
    private func loadYouTubeVideo(videoID: String, in webView: WKWebView) {
        // Construir la URL para incrustar el video de YouTube
        let embedURLString = "https://www.youtube.com/embed/\(videoID)"
        
        if let url = URL(string: embedURLString) {
            let request = URLRequest(url: url)
            webView.load(request) // Cargar el video en el WebView especificado
        } else {
            print("URL inválida para el video de YouTube")
        }
    }
    
}
