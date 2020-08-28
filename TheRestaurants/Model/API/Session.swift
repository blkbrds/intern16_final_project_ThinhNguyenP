//
//  Session.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation

//struct PopUpResult {
//    var popUpResult: [PopUpLocation]
//}

//enum APIResult<T> {
//    case failure(String)
//    case success(T)
//}

//typealias APICompletion<T> = (APIResult<T>) -> Void

final class Session {
//    private static var sharedNetworking: Session = {
//        let networking = Session()
//        return networking
//    }()
//    class func shared() -> Session {
//        return sharedNetworking
//    }
    
//    func popUpSearch(completion: @escaping APICompletion<PopUpResult>) {
//        let param = Api.Search.SearchParam(value: <#T##String#>)
////        let urlString = Api.Path.Search(key: keywork).url
//        guard let url = URL(string: urlString) else {
//            completion(.failure(App.String.alertFailedAPI))
//            return
//        }
//        let config = URLSessionConfiguration.ephemeral
//        config.waitsForConnectivity = true
//        let session = URLSession(configuration: config)
//        let task = session.dataTask(with: url) { (data, _, error ) in
//            DispatchQueue.main.async {
//                guard error == nil else {
//                    completion(APIResult.failure(App.String.alertFailedToConnectAPI))
//                    return
//                }
//                if let error = error {
//                    completion(.failure(error.localizedDescription))
//                }
//                var resultsPopUp: [PopUpLocation] = []
//                if let data = data {
//                    let json = data.toJSON()
//                    guard let locationResult = json["location_suggestions"] as? [JSON] else { return }
//                    locationResult.forEach { (drink) in
//                        let item = PopUpLocation(json: drink)
//                        resultsPopUp.append(item)
//                    }
////                    for item in locationResult {
////                        let resultPopUp = PopUpLocation(json: item)
////                        resultsPopUp.append(resultPopUp)
////                        print(resultsPopUp)
////                    }
//                     completion(.success(PopUpResult(popUpResult: resultsPopUp)))
//                }
//            }
//        }
//        task.resume()
//    }
}
