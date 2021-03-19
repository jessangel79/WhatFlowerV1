//
//  ViewController.swift
//  WhatFlowerV1
//
//  Created by Angelique Babin on 19/03/2021.
//

import UIKit

import UIKit
import CoreML
import Vision

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
//    private let wikiService = WikiService()
//    private var flowerName: String?

    // MARK: - Actions
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
  
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImagePicker()
    }
    
    // MARK: - Methods
    
//    private func getFlowerDescription(flowerName: String) {
//        wikiService.getFlowerDescription(flowerName: flowerName) { [self] (success, result) in
//            guard let result = result else { return }
//            print(result)
//            descriptionTextView.text = result
//        }
////        guard let flowerName = flowerName else {
//// //            return
////            fatalError("error with the noame of flower")
////        }
//
////        wikiService.getFlowerDescription(flowerName: flowerName) { (success, result) in
////            if success {
////                guard let result = result else { return }
////                print(result)
////                let pageIds = result.query.pageids[0]
////                print(pageIds)
////
////    // //                let extract = result.query.pages.the1276123.extract
////    //                let extract = result.query.pages.the1276123.extract
////    //                print(extract)
////
////            } else {
////                print("error get Flower")
////            }
////        }
//    }
}

// MARK: - Extension UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = userPickedImage
            guard let convertedCIImage = CIImage(image: userPickedImage) else { return }
//            detect(flowerImage: convertedCIImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    private func setImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
//    private func detect(flowerImage: CIImage) {
//        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: .init()).model) else { return }
//
//        let request = VNCoreMLRequest(model: model) { [self] (request, error) in
//            guard let classification = request.results?.first as? VNClassificationObservation else {
//                fatalError("Could not classify image.")
//            }
////            flowerName = classification.identifier
////            print(flowerName ?? "error name flower")
//            navigationItem.title = classification.identifier.capitalized
//            getFlowerDescription(flowerName: classification.identifier)
//            print(classification.identifier.capitalized)
//
////            guard let results = request.results as? [VNClassificationObservation] else { return }
////            if let firstResult = results.first {
////                self.navigationItem.title = firstResult.identifier.capitalized
////            }
//
//            print(request.results?[0] ?? "Error 0", request.results?[1] ?? "Error 1", request.results?[2] ?? "Error 2")
//        }
//
//        let handler = VNImageRequestHandler(ciImage: flowerImage)
//        do {
//            try handler.perform([request])
//        } catch {
//            print(error)
//        }
//    }
}

