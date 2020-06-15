//
//  AddItemViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/22/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var itemImagesCollectionView: UICollectionView!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var addPhotos: UIBarButtonItem!
    @IBOutlet weak var categories: UIPickerView!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var addItem: UIButton!
    //@IBOutlet weak var itemTags: UITextField!
    @IBOutlet weak var noImage: UIImageView!
    
    var itemStatus = false//true is new
    var catogeriesData: [String]!
    var item: ItemFS!
    var catID: String!
    var itemImages =  [UIImage]()
    
    private let sectionInsets = UIEdgeInsets(top: 0,
                                             left: 0,
                                             bottom: 0,
                                             right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categories.delegate = self
        self.categories.dataSource = self
        
        self.itemImagesCollectionView.delegate = self
        self.itemImagesCollectionView.dataSource = self
        
        itemDescription.layer.borderWidth = 1
        itemDescription.layer.borderColor = UIColor.black.cgColor
        
        addPhotos.isEnabled = false
        uitextviewPlaceholder()
        loadCategories()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        itemImagesCollectionView.reloadData()
    }
    
    
    @IBAction func addPhotos(_ sender: Any) {
        print("function add photots called")
        pickAnImageFromAlbum()
    }
    
    
    @IBAction func itemStatus(_ sender: Any) {
        let status = sender as! UISegmentedControl
        switch status.selectedSegmentIndex
        {
        case 0:
            self.itemStatus = true
        default:
            self.itemStatus = false
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        if (itemDescription.text!.isEmpty || itemName.text!.isEmpty || itemQuantity.text!.isEmpty || itemPrice.text!.isEmpty) {
            let alert = UIAlertController(title: "Empty Fields", message: "All fields are required to be fill.",preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { Void in }))
            self.present(alert,animated:true,completion:nil)
        } else {
            
            let price = Double(itemPrice.text!)
            
            if(price! < 0 || Int(itemQuantity.text!)! < 1) {
                let alert = UIAlertController(title: "Error ", message: "Price, and Quantity have to be filled correctly.",preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay, I will check", style: UIAlertAction.Style.default, handler: { Void in }))
                self.present(alert,animated:true,completion:nil)
            } else {
                let itemVM = ItemVM(categoryId: catID, userId: API.user.id, name: itemName.text, details: itemDescription.text, price: price, isNew: itemStatus, quantity: Int(itemQuantity.text!))
                
                NetworkLayer.addItem(itemVM: itemVM, controller: self)

                self.addPhotos.isEnabled = true
                self.addItem.isEnabled = false
                
                AlertClass.showAlert(controller: self, message: "Please do not forget to upload photos to the item", seconds: 2.0)
            }
        }
    }
    
    func loadCategories() {
        NetworkLayer.loadCategories(controller: self)
    }
}

extension AddItemViewController: UITextViewDelegate {
    
    func uitextviewPlaceholder() {
        itemDescription.text = "Item description"
        itemDescription.textColor = UIColor.lightGray
        itemDescription.font = UIFont(name: "verdana", size: 13.0)
        itemDescription.returnKeyType = .done
        itemDescription.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Item description" {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 18.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Item description"
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AddItemViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return API.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return API.categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if API.categories.count > 0 {
            self.catID = API.categories[row].id
        } else {
            AlertClass.showAlert(controller: self, message: "No internet connection, please check internet connection to be able to load categories.", seconds: 3.0)
        }
    }
    
}

extension AddItemViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    func pickAnImageFromAlbum() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else { return }
        itemImages.append(image)
        NetworkLayer.addImageToItem(itemID: item.id, image: image)
        itemImagesCollectionView.reloadData()
    }
}

extension AddItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * 3
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2.1
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if itemImages.count == 0 {
            noImage.image = UIImage(named: "no-image-available.png")
            noImage.isHidden = false
        } else {
            noImage.isHidden = true
        }
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddItemImagesCollectionViewCell", for: indexPath) as! AddItemImagesCollectionViewCell
        viewCell.setData(data: itemImages[indexPath.row])
        return viewCell
    }
}
