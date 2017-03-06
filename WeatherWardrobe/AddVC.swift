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
    var clothingType = ["Outerwear", "Shirt", "Pants", "Shoes"]
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
        // enables to work/interact w/ core data
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        ClothingTypeTextField.becomeFirstResponder()
    }

    // camera imageView is tapped
    @IBAction func imageTapped(_ sender: Any) {
        // create pop up
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
        // check if image is selected, if no image return
        if cameraImageView.image == nil{
            return
        }
        // if there's image save & dismiss
        self.saveImage(image: cameraImageView.image!)
        self.dismiss(animated: true, completion: nil)
    }
    
    // store image to core data
    func saveImage(image: UIImage) {
        // get ClothingTypeTextField and create new entity
        let newImage = NSEntityDescription.entity(forEntityName: ClothingTypeTextField.text!, in: self.managedObjectContext)!
        
        let object = NSManagedObject(entity: newImage, insertInto: self.managedObjectContext)
        
        // set value of image to label/category
        object.setValue(image, forKey: "image")
        
        // store new object
        do {
            // save
            try managedObjectContext.save()
        } catch let error as NSError {
            // process error
            print("could not save the new entry \(error.description)")
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// take a photo with the camera or pick an image from the photo library to be able to display it in an imageView
// http://stackoverflow.com/questions/39812390/how-to-load-image-from-camera-or-photo-library-in-swift
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

    // implement the handler after an image is selected or when the Image Picker is closed
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image: UIImage? = info[UIImagePickerControllerEditedImage] as! UIImage?
        cameraImageView.image = image

        
        picker.dismiss(animated: true, completion: { _ in })
    }
}

// functions in order for picker to be functional
extension AddVC: UIPickerViewDataSource, UIPickerViewDelegate {
    // how many sections there are in a row?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // defines how many rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clothingType.count
    }
    
    // display selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ClothingTypeTextField.text = clothingType[row]
    }
    
    // what text should be in each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clothingType[row]
    }
}
