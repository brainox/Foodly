//
//  DishCategory.swift
//  Foodly
//
//  Created by Decagon on 05/06/2021.
//

import UIKit

struct DishCategory {
    let name: String
    let image: UIImage
}

enum FoodCategories: String {
    case all = "All"
    case pizza = "Pizza"
    case beverages = "Beverages"
    case asian = "Asian"
    case fastfood = "Fast Food"
    case continental = "Continental"
    case healthy = "healthy"
}

class MealsViewModel {
    let categories: [DishCategory] = [
        
        DishCategory( name: FoodCategories.all.rawValue, image: UIImage(imageLiteralResourceName: "ion_fast-food-outline")),
        
        DishCategory(name: FoodCategories.pizza.rawValue, image: UIImage(imageLiteralResourceName: "Pizza")),
        
        DishCategory( name: FoodCategories.beverages.rawValue, image: UIImage(imageLiteralResourceName: "Drink")),
        
        DishCategory(name: FoodCategories.asian.rawValue, image: UIImage(imageLiteralResourceName: "ricecracker")),
        
        DishCategory(name: FoodCategories.fastfood.rawValue, image: UIImage(imageLiteralResourceName: "Drink")),
        
        DishCategory(name: FoodCategories.continental.rawValue, image: UIImage(imageLiteralResourceName: "ricecracker")),
        
        DishCategory(name: FoodCategories.healthy.rawValue, image: UIImage(imageLiteralResourceName: "Pizza"))
        
    ]
    
}
