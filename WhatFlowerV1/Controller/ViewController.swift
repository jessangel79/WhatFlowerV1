//
//  ViewController.swift
//  WhatFlowerV1
//
//  Created by Angelique Babin on 19/03/2021.
//

import UIKit
import CoreML
import Vision

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private let wikiService = WikiService()

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
    
    private func getFlowerDescription(flowerName: String) {
        wikiService.getFlowerDescription(flowerName: flowerName) { [self] (_, result) in
            guard let result = result else { return }
            if result.isEmpty {
                descriptionTextView.text = "Sorry no description available !"
            } else {
                descriptionTextView.text = result
                print(result)
            }
        }
    }
}

// MARK: - Extension UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = userPickedImage
            guard let convertedCIImage = CIImage(image: userPickedImage) else { return }
            detect(flowerImage: convertedCIImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    private func setImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
    private func detect(flowerImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: .init()).model) else { return }

        let request = VNCoreMLRequest(model: model) { [self] (request, error) in
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify image.")
            }
//            flowerName = classification.identifier
//            print(flowerName ?? "error name flower")
            navigationItem.title = classification.identifier.capitalized
            getFlowerDescription(flowerName: classification.identifier)
            print(classification.identifier.capitalized)

//            guard let results = request.results as? [VNClassificationObservation] else { return }
//            if let firstResult = results.first {
//                self.navigationItem.title = firstResult.identifier.capitalized
//            }

            print(request.results?[0] ?? "Error 0", request.results?[1] ?? "Error 1", request.results?[2] ?? "Error 2")
        }

        let handler = VNImageRequestHandler(ciImage: flowerImage)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
