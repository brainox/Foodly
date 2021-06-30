//
//  HomeScreenViewModel.swift
//  Foodly
//
//  Created by Decagon on 24/06/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

let home = HomeScreenViewController()
class HomeScreenViewModel {
    
     func getUserName() {
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let status = docData!["fullName"] as? String ?? ""
                let firstWord = status.components(separatedBy: " ").first
                
                home.welcomeLabel.text = "\(self.gettime()), \(firstWord!)"
            } else {
                print(error as Any)
            }
        }
    }
    
    func gettime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 1..<12 :
            return(NSLocalizedString("Good Morning", comment: "Morning"))
        case 12..<17 :
            return (NSLocalizedString("Good Afternoon", comment: "Afternoon"))
        default:
            return (NSLocalizedString("Good Evening", comment: "Evening"))
        }
        
    }
    
    var restaurantList = [Restaurants]()
    let restaurantsService = RestaurantService()
    var restaurantIDS = [String]()
    
    var closure:(() -> Void)? // created closure
    
    func fetchRestaurants() {
        
        restaurantsService.getRestaurants { (output) in
            switch output {
            case .failure(let error):
                print(error)
            case .success(let queryDocument):
                queryDocument?.documents.forEach({ (result) in
                    let resultData = result.data()
                    if let restaurantName = resultData["name"] as? String,
                       let imageName = resultData["imageName"] as? String,
                       let discount = resultData["discount"] as? String,
                       let mealType = resultData["mealType"] as? String,
                       let time = resultData["time"] as? String,
                       let restID = result.documentID as? String{
                        let eachRestaurant = Restaurants(restaurantName: restaurantName,
                                                         restaurantImage: UIImage(imageLiteralResourceName: imageName),
                                                         category: mealType,
                                                         timeLabel: time, discountLabel: discount)
                        
                        self.restaurantList.append(eachRestaurant)
                        self.restaurantIDS.append(restID)
                        
                    }
                    
                })
                self.closure?()// optionally call closure
            }
        }
    }
}
