//
//  WikiSession.swift
//  WhatFlowerV1
//
//  Created by Angelique Babin on 19/03/2021.
//

import Foundation
import Alamofire

//class WikiSession: WikiProtocol {
//    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) { // @escaping (DataResponse<Any, AFError>)
//        AF.request(url).responseJSON { responseData in
//            completionHandler(responseData)
//        }
//    }
//}

class WikiSession: WikiProtocol {
    
    func request(flowerName: String, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        let parameters: [String: String] = [
            "format": "json",
            "action": "query",
            "prop": "extracts|pageimages",
            "exintro": "",
            "explaintext": "",
            "titles": flowerName,
            "indexpageids": "",
            "redirects": "1",
            "pithumbsize": "500"
        ]
        
        AF.request(wikipediaUrl, method: .get, parameters: parameters).responseJSON { (responseData) in
            completionHandler(responseData)
        }
    }
}
