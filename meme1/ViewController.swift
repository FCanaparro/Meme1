//
//  ViewController.swift
//  meme1
//
//  Created by Felix Canaparro on 22/11/2017.
//  Copyright © 2017 Felix Canaparro. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
   
    
    @IBOutlet weak var textoAcima: UITextField!
    @IBOutlet weak var textoAbaixo: UITextField!
    @IBOutlet weak var Camera: UIButton!
    @IBOutlet weak var Fotos: UIButton!
    
    var attributes = [NSAttributedStringKey : Any]()
    let textoAcimaDelegate = MemeTextFieldDelegate()
    let textoAbaixoDelegate = MemeTextFieldDelegate()
    
    
     var meme = Meme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicializaBarra()
        InicializaTexto(element: textoAcima, text: meme.textTop, delegate: textoAcimaDelegate)
        InicializaTexto(element: textoAbaixo, text: meme.textBottom, delegate: textoAbaixoDelegate)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func inicializaBarra() {
        Camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        Fotos.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    
    
    
    func InicializaTexto(element: UITextField, text: String, delegate: UITextFieldDelegate) {
        attributes = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth: -2.6,
            ]
        element.text = text
        element.delegate = delegate
        //element.defaultTextAtt
        element.textAlignment = NSTextAlignment.center
        element.isHidden = true
    }
    
    
    
    

}

