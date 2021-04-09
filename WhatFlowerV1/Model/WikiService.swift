//
//  WikiService.swift
//  WhatFlowerV1
//
//  Created by Angelique Babin on 19/03/2021.
//

import Foundation
import SwiftyJSON

final class WikiService {
    
    // MARK: - Properties
    
    private let wikiSession: WikiProtocol
    
    init(wikiSession: WikiProtocol = WikiSession()) {
        self.wikiSession = wikiSession
    }
    
    // MARK: - Methods
    
    func getFlowerDescription(flowerName: String, completionHandler: @escaping (Bool, [String]?) -> Void) {
        wikiSession.request(flowerName: flowerName) { (responseData) in
            
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            
            if case .success(let value) = responseData.result {
                print("Got the wikipedia info.")
                print(responseData.result)
                print(value)
                let flowerJSON: JSON = JSON(value)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                let flowerDatas = [flowerDescription, flowerImageURL]
                completionHandler(true, flowerDatas) // flowerDescription
            } else {
                completionHandler(false, nil)
                return
            }
//            switch responseData.result {
//            case .success(let value):
//                print("Got the wikipedia info.")
//                print(responseData.result)
//                print(value)
//                let flowerJSON: JSON = JSON(value)
//                let pageid = flowerJSON["query"]["pageids"][0].stringValue
//                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
//                completionHandler(true, flowerDescription)
//            case .failure(let error):
//                completionHandler(false, error.errorDescription)
//                return
//            }

        }
    }
}
