//
//  ViewController.swift
//  meme1
//
//  Created by Felix Canaparro on 22/11/2017.
//  Copyright © 2017 Felix Canaparro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var textoAcima: UITextField!
    @IBOutlet weak var textoAbaixo: UITextField!
    @IBOutlet weak var Camera: UIButton!
    @IBOutlet weak var Fotos: UIButton!
    @IBOutlet weak var Compartilhar: UIButton!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    var attributes = [NSAttributedStringKey : Any]()
    let textoAcimaDelegate = MemeTextFieldDelegate()
    let textoAbaixoDelegate = MemeTextFieldDelegate()
    var meme = Meme()
    
    @IBAction func origemCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickInferior(_ sender: Any) {
    }
    @IBAction func clickSuperior(_ sender: Any) {
    }
    
    @IBAction func origemBiblioteca(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicializaBarra()
        InicializaTexto(element: textoAcima, text: meme.textTop, delegate: textoAcimaDelegate)
        InicializaTexto(element: textoAbaixo, text: meme.textBottom, delegate: textoAbaixoDelegate)
     
    
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func inicializaBarra() {
        Camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        Fotos.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        Compartilhar.isEnabled=false
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
        //lement.defaultTextAttributes =
        element.textAlignment = NSTextAlignment.center
        element.isHidden = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
            as! UIImage
        imagePickerView.image=image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
    }
    
    
    
    
    
    
    
    
}

