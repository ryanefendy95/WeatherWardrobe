//
//  AddVC.swift
//  WeatherWardrobe
//
//  Created by Ryan Efendy on 2/01/17.
//  Copyright © 2017 Ryan Efendy. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class AddVC: UIViewController {

    
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var ClothingTypeTextField: UITextField!
    
    
    
    var clothingTypePicker = UIPickerView()
    var clothingType = ["OuterWear", "Shirt", "Pants", "Shoes/Accessories"]
    
    var clothingTypeStored: CurrentUser.catagories = CurrentUser.catagories.outerwear
    
    // Core Data
    var managedObjectContext: NSManagedObjectContext!
    var entry: NSManagedObject!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        clothingTypePicker.dataSource = self
        clothingTypePicker.delegate = self
        clothingTypePicker.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddVC.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)

        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        ClothingTypeTextField.inputView = clothingTypePicker
        ClothingTypeTextField.inputAccessoryView = toolBar
        
        // Core Data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print("error")
                return
        }
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        ClothingTypeTextField.becomeFirstResponder()
        

    }

    @IBAction func imageTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Open camera", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            let _ = self.PresentPhotoCamera()
        })
        let action2 = UIAlertAction(title: "Photo library", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            let _ = self.PresentPhotoLibrary()
        })
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        self.present(alert, animated: true, completion: { _ in })
        
    }
    
    

    
    func donePicker() {
        
        ClothingTypeTextField.resignFirstResponder()
        
    }
    

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        if cameraImageView.image == nil{
            return
        }
        
        
        
        
        self.saveImage(image: cameraImageView.image!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func saveImage(image: UIImage) {
        
        let outerwearImages = NSEntityDescription.entity(forEntityName: "OuterWearImages", in: self.managedObjectContext)!
        let object = NSManagedObject(entity: outerwearImages, insertInto: self.managedObjectContext)
        
        object.setValue(image, forKey: "image")
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("could not save the new entry \(error.description)")
        }
        
    }
    

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension AddVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func PresentPhotoCamera() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return false
        }
        
        let type: String? = (kUTTypeImage as String)
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) && (UIImagePickerController.availableMediaTypes(for: .camera)?.contains(type!))! {
            imagePicker.mediaTypes = [type!]
            imagePicker.sourceType = .camera
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imagePicker.cameraDevice = .rear
            }
            else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                imagePicker.cameraDevice = .front
            }
        }
        else {
            return false
        }
        imagePicker.allowsEditing = true
        imagePicker.showsCameraControls = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: { _ in })
        
        return true
    }
    
    func PresentPhotoLibrary() -> Bool {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false && UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false) {
            return false
        }
        let type: String? = (kUTTypeImage as String)
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) && UIImagePickerController.availableMediaTypes(for: .photoLibrary)!.contains(type!) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [type!]
        }
        else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) && UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!.contains(type!) {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.mediaTypes = [type!]
        }
        else {
            return false
        }
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: { _ in })
        
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image: UIImage? = info[UIImagePickerControllerEditedImage] as! UIImage?
        cameraImageView.image = image

        
        picker.dismiss(animated: true, completion: { _ in })
        
    }
    
    

    
}

extension AddVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clothingType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ClothingTypeTextField.text = clothingType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clothingType[row]
    }
    
}
