//
//  AddEditViewController.swift
//  MyCloset
//
//  Created by GraceToa on 28/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class AddClotheViewController: UIViewController {
    
    @IBOutlet weak var tableCateg: UITableView!
    @IBOutlet weak var tableOcassion: UITableView!
    @IBOutlet weak var tableStation: UITableView!
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var ocassionBtn: UIButton!
    @IBOutlet weak var stationBtn: UIButton!
    
    var categories = Manager.shared.categories
    var ocassions = Manager.shared.ocassion
    var seasons = Manager.shared.seasons
    var type: String = ""
    var ocassion: String = ""
    var season: String = ""
    var category: String!
    var id: Int16 = 0
    var image: UIImage!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        let cameraBtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(actionCamera))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItems = [doneBtn,cameraBtn]
        
        tableCateg.isHidden = true
        tableOcassion.isHidden = true
        tableStation.isHidden = true
        
        typeBtn.layer.cornerRadius = 15
        ocassionBtn.layer.cornerRadius = 15
        stationBtn.layer.cornerRadius = 15
        
    }
  
    // MARK: - Actions COREDATA
    
    @objc func done()  {
        let rating = ratingControl.rating
        category = getNameCategory(type: type)
        
        if type == "What's the type?" || ocassion == "What's the Ocassion?" || season == "for what Season?" || image == nil  || rating == 0 {
            let alert = UIAlertController(title: "Error fields", message: "The fields are empty!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let imgEnd = image.jpegData(compressionQuality: 0.25) as NSData?
            Clothe.insertNewClothe(image: imgEnd!, category: category, ocassion: ocassion, rating: Int16(rating), season: season, type: type)
            showToast(message: "OK, Add Clothe¡")
            cleanFields()
        }
    }
 
    
    // MARK: - Actions Table Methods
    
    @IBAction func type(_ sender: UIButton) {
        if tableCateg.isHidden {
            animate(toogle: true, tableView: tableCateg)
        }else{
            animate(toogle: false, tableView: tableCateg)
        }
    }
    
    @IBAction func ocassion(_ sender: UIButton) {
        if tableOcassion.isHidden {
            animate(toogle: true, tableView: tableOcassion)
        }else{
            animate(toogle: false, tableView: tableStation)
        }
    }
    
    @IBAction func station(_ sender: UIButton) {
        if tableStation.isHidden {
            animate(toogle: true, tableView: tableStation)
        }else{
            animate(toogle: false, tableView: tableStation)
        }
    }
    
    // MARK: - Method Private

    func animate(toogle: Bool, tableView: UITableView)  {
        if toogle {
            UIView.animate(withDuration: 0.3) {
                if tableView == self.tableCateg {
                    self.tableCateg.isHidden = false
                }else if tableView == self.tableOcassion {
                    self.tableOcassion.isHidden = false
                }else {
                    self.tableStation.isHidden = false
                }
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                if tableView == self.tableCateg {
                    self.tableCateg.isHidden = true
                }else if tableView == self.tableOcassion {
                    self.tableOcassion.isHidden = true
                }else {
                    self.tableStation.isHidden = true
                }
            }
        }
    }
    
    func getNameCategory(type: String) -> String {
        var categ = ""
        if type == "Jewelry" || type == "Handbags" || type == "Glasses" {
            categ = "Accessories"
        }else if  type == "Dress"{
            categ = "Dresses"
        }else if  type == "Jackets"{
            categ = "Coat"
        }else if  type == "Sneakers" || type == "Stiletos" {
            categ = "Shoes"
        }else if  type == "Shirt" || type == "T-shirt"{
            categ = "Tops"
        }else if  type == "Jeans" || type == "Pants"{
            categ = "Trousers"
        }
        return categ
    }
    
    func cleanFields()  {
        typeBtn.setTitle("What's the type?", for: .normal)
        ocassionBtn.setTitle("What's the Ocassion?", for: .normal)
        stationBtn.setTitle("for what Season?", for: .normal)
        ratingControl.rating = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions Alert
    
    @objc func actionCamera()  {
        let alert = UIAlertController(title: "take Photo", message: "camera/library", preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.takePhoto()
        }
        let actionLibrary = UIAlertAction(title: "Library", style: .default) { (action) in
            self.takeLibrary()
        }
        let actionCancel =  UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
 
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


extension AddClotheViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if tableView == tableCateg {
            count = categories.count
        }else if tableView == tableOcassion{
            count = ocassions.count
        }else{
            count = seasons.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableCateg {
            let cell = tableCateg.dequeueReusableCell(withIdentifier: "cellCateg", for: indexPath)
            cell.textLabel?.text = categories[indexPath.row]
            return cell
        } else if  tableView == tableOcassion {
            let cell = tableOcassion.dequeueReusableCell(withIdentifier: "cellOcassion", for: indexPath)
            cell.textLabel?.text = ocassions[indexPath.row]
            return cell
        }
        let cell = tableStation.dequeueReusableCell(withIdentifier: "cellStation", for: indexPath)
            cell.textLabel?.text = seasons[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableCateg {
            type = categories[indexPath.row]
            typeBtn.setTitle("\(categories[indexPath.row])", for: .normal)
            animate(toogle: false,tableView: tableCateg)
        }else if tableView == tableOcassion {
            ocassion = ocassions[indexPath.row]
            ocassionBtn.setTitle("\(ocassions[indexPath.row])", for: .normal)
            animate(toogle: false,tableView: tableOcassion)
        }else {
            season = seasons[indexPath.row]
            stationBtn.setTitle("\(seasons[indexPath.row])", for: .normal)
            animate(toogle: false,tableView: tableStation)
        }
    }
}


extension AddClotheViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageTake = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        image = imageTake
        imagePhoto.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
        
    func takePhoto() {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func takeLibrary()  {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
}
