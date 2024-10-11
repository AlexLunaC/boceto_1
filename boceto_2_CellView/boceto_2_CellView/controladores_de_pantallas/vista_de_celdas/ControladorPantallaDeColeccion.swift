//
//  ControladorPantallaDeColeccion.swift
//  boceto_2_CellView
//
//  Created by alumno on 10/7/24.
//

import UIKit


class ControladorPantallaPrincipalDeColeccion: UICollectionViewController{
    private var lista_de_publicaciones: [Publicacion] = []
    let url_de_publicaciones = "https://jsonplaceholder.typicode.com/posts"
    
    
    private let identificador_de_celda = "celda_pantalla_principal"
    
    let proveedor_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    @IBOutlet weak var outlet_a_la_vista: UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let ubicacion = URL(string: url_de_publicaciones)!
        URLSession.shared.dataTask(with: ubicacion) {
            (datos, respuesta, error) in do {
                if let publicaciones_recibidas = datos{
                    let prueba_de_interpretacion_de_datos = try JSONDecoder().decode([Publicacion].self, from: publicaciones_recibidas)
                    
                    self.lista_de_publicaciones = prueba_de_interpretacion_de_datos
                    
                    DispatchQueue.main.async {                        self.collectionView.reloadData()
                    }
                }
                else {
                    print(respuesta)
                }
            } catch {
                print("Error")
            }
        }.resume()
        
        /*
         proveedor_publicaciones.obtener_publicaicones{
         [weak self] (publicaciones) in self?.lista_de_publicaciones = publicaciones
         DispatchQueue.main.async {
         self?.collectionView.reloadData()
         }
         }
         */
        
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.lista_de_publicaciones.count
    }
    
    // Funcion para identificar y crear cada una de las celdas creadas en el Controller
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda: VistaDeCelda = collectionView.dequeueReusableCell(withReuseIdentifier: identificador_de_celda, for: indexPath) as! VistaDeCelda
        
        // Configure the cell
        //celda.tintColor = UIColor.green
        
        celda.etiqueta.text = self.lista_de_publicaciones[indexPath.item].title
        celda.cuerpo.text = self.lista_de_publicaciones[indexPath.item].body
        
        // print(self.lista_de_publicaciones)
        
        return celda
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Se selecciono la celda\(indexPath)")
        
        let pantalla_de_publicacion = storyboard?.instantiateViewController(withIdentifier: "PantallaPublicacion") as! ControladorPantallaDelPost
        
        self.navigationController?.pushViewController(pantalla_de_publicacion, animated: true)
        
        print(self.navigationController)
        
    }
    
    // MARK: UICollectionViewDelegate
    
    /*extension ControladorPantallaPrincipalDeColeccion: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
     
     return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
     }
     // Method 2
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     
     return 5
     }
     // Method 3
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
     
     return 5
     }
     //Method 4
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
     let collectionViewWidth = self.collectionView.frame.width
     let collectionViewHeight =  self.collectionView.frame.height
     
     let cellWidth = (collectionViewWidth) / 1.1
     let cellHeight = cellWidth * 0.5
     
     return CGSize(width: cellWidth , height: cellHeight)
     
     }
     
     override func viewWillLayoutSubviews() {
     print("REPRENDER ESTAS mmadas")
     
     }
     
     override func viewWillAppear(_ animated: Bool) {
     (self.navigationController as? mod_navegador_principal)?.activar_navigation_bar(actviar: false)
     
     }
     }+/
     
     
     /*
      class ControladorPantallaGRIDCollectionView: UICollectionViewDelegate {
      private let itemsPerRow: CGFloat = 3
      private let minimumItemSpacing: CGFloat = 8
      private let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
      
      // MARK: - UICollectionViewDelegateFlowLayout
      func collectionView(_ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize: CGSize
      if indexPath.item % 4 == 0 {
      let itemWidth = collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
      itemSize = CGSize(width: itemWidth, height: 112)
      } else {
      let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
      let availableWidth = collectionView.bounds.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      itemSize = CGSize(width: widthPerItem, height: widthPerItem)
      }
      return itemSize
      }
      
      func collectionView(_ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
      }
      
      func collectionView(_ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 20
      }
      
      func collectionView(_ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return minimumItemSpacing
      }
      }
      */
     */
}
