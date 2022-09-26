//
//  ViewController.swift
//  PhotoAccessPermission
//
//  Created by Prraneth Kumar A R on 26/09/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Displaying & Uploading Image"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.saveImageToAlbum))
        
    }
    
    @objc func saveImageToAlbum(){
        guard let image = imageView.image else{
            let alertController = UIAlertController(title: "Enter Details Correctly", message: "Upload Photo", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true){
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                alertController.view.superview?.addGestureRecognizer(tapGesture)
            }
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(vc,animated: true)
        
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func UploadBtn(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        
        //for PhotoLibrary
        imagePickerVC.sourceType = .photoLibrary
        
        //for Album
   //     imagePickerVC.sourceType = .savedPhotosAlbum

        imagePickerVC.delegate = self // new
        
        //presenting Photo Library
        present(imagePickerVC, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
    }
    
}

