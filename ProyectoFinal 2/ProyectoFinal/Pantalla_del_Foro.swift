//
//  Pantalla_del_Foro.swift
//  ProyectoFinal
//
//  Created by alumno on 11/11/24.
//

import Foundation

import UIKit

// Estructura para representar una publicación
struct Post {
    let Titulo: String
    let Autor: String
    let Contenido: String
}
class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var contenidoLabel: UILabel!
}

class Pantalla_Del_Foro: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Array para almacenar publicaciones
    var posts: [Post] = []
    
    // Outlets para los componentes de la interfaz
    @IBOutlet weak var TituloTextField: UITextField!
    @IBOutlet weak var AutorTextField: UITextField!
    @IBOutlet weak var ContenidoTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar la tabla
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Acción para el botón de crear publicación
    @IBAction func createPostButtonTapped(_ sender: UIButton) {
        // Validar que los campos no estén vacíos
        guard let Titulo = TituloTextField.text, !Titulo.isEmpty,
              let Autor = AutorTextField.text, !Autor.isEmpty,
              let Contenido = ContenidoTextView.text, !Contenido.isEmpty else {
            // Mostrar alerta si falta información
            let alert = UIAlertController(title: "Error", message: "Todos los campos son obligatorios.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        translateText(Contenido) { [weak self] translatedContent in
            DispatchQueue.main.async {
                // Crear una nueva publicación con el texto traducido
                let newPost = Post(Titulo: Titulo, Autor: Autor, Contenido: translatedContent)
                self?.posts.append(newPost)
                
                // Recargar la tabla para mostrar la nueva publicación
                self?.tableView.reloadData()
                
                // Limpiar los campos después de crear la publicación
                self?.TituloTextField.text = ""
                self?.AutorTextField.text = ""
                self?.ContenidoTextView.text = ""
            }
        }
    }
    
    // MARK: - Métodos del UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Intentar obtener la celda personalizada
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaPost", for: indexPath) as? PostTableViewCell else {
            fatalError("No se pudo cargar la celda personalizada")
        }
        
        // Obtener la publicación correspondiente
        let post = posts[indexPath.row]
        
        // Configurar la celda
        cell.tituloLabel.text = post.Titulo
        cell.autorLabel.text = "Por \(post.Autor)"
        cell.contenidoLabel.text = post.Contenido
        cell.contenidoLabel.numberOfLines = 0
        
        return cell
    }
    // Función para censurar el texto utilizando tu API
    func translateText(_ text: String, completion: @escaping (String) -> Void) {
        // Usar la URL de la API de MyMemory
        let urlString = "https://api.mymemory.translated.net/get?q=\(text)&langpair=es|en" // Cambia los idiomas según lo necesario
        guard let url = URL(string: urlString) else {
            print("Error: URL inválida.")
            completion(text) // Retornar el texto original si no se puede construir la URL
            return
        }
        print("Solicitando a la URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  // Usar GET si no se necesita POST
        
        // Realizar la solicitud
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error al realizar la solicitud: \(error.localizedDescription)")
                completion(text) // Retornar el texto original si ocurre un error
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: No se recibió una respuesta HTTP válida.")
                completion(text)
                return
            }
            
            print("Código de respuesta HTTP: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode != 200 {
                print("Error: Respuesta de la API con código \(httpResponse.statusCode)")
                completion(text)
                return
            }
            
            guard let data = data else {
                print("Error: Datos vacíos recibidos de la API.")
                completion(text)
                return
            }
            
            do {
                // Intentamos convertir la respuesta JSON a un diccionario
                if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    // Accedemos al diccionario "responseData" de forma segura
                    if let responseData = jsonResponse["responseData"] as? [String: Any],
                       let translatedText = responseData["translatedText"] as? String {
                        print("Texto traducido recibido: \(translatedText)")
                        completion(translatedText)
                    } else {
                        print("Error: El formato de la respuesta no es el esperado. Respuesta completa: \(String(data: data, encoding: .utf8) ?? "N/A")")
                        completion(text)
                    }
                } else {
                    print("Error: La respuesta no es un diccionario válido. Respuesta completa: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    completion(text)
                }
            } catch {
                print("Error al analizar la respuesta JSON: \(error)")
                completion(text)
            }
        }.resume()
    }
    
}
