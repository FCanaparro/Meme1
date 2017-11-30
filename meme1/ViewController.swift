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
    
    @IBAction func clickCancelar(_ sender: Any) {
        imagePickerView.image=nil
        InicializaTexto(element: textoAcima, text: meme.textTop, delegate: textoAcimaDelegate)
        InicializaTexto(element: textoAbaixo, text: meme.textBottom, delegate: textoAbaixoDelegate)
        
        
    }
    @IBAction func clickInferior(_ sender: Any) {
        Compartilhar.isEnabled=true
    }
    @IBAction func clickSuperior(_ sender: Any) {
        Compartilhar.isEnabled=true
    }
    
    
    func selecionaOrigem(sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func origemCamera(_ sender: Any) {
        selecionaOrigem(sourceType:(.photoLibrary))
    }
    
    @IBAction func origemBiblioteca(_ sender: Any) {
        selecionaOrigem(sourceType:(.camera))
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
    
    @IBAction func compartilhar(_ sender: Any) {
        
        
        let ac = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        ac.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            }
        }
        present(ac, animated: true, completion: nil)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    func save() {
        // Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme(textTop: textoAcima.text!, textBottom: textoAbaixo.text!, imageOriginal: imagePickerView.image!, memedImage: memedImage)
    }
    
    
    func InicializaTexto(element: UITextField, text: String, delegate: UITextFieldDelegate) {
       let attributes: [String:Any]=[
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -2.9,
            ]
        element.text = text
        element.delegate = delegate
        element.defaultTextAttributes = attributes
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
        if textoAbaixo.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    func keyboardWillHide(notification: NSNotification) -> Void {
        
        if textoAcima.isFirstResponder {
            view.frame.origin.y = 0
        }
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
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
    
    
    
    
    
}

