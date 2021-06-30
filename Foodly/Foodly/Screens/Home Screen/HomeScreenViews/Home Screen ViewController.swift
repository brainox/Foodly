//
//  Home Screen ViewController.swift
//  Foodly
//
//  Created by Decagon on 05/06/2021.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var emptyArr = [Restaurants]()
    var restaurantCategories = [Restaurants]()
    var passDiscount: ((String, String)->Void)?
    
    
    var homeScreen = HomeScreenViewModel()
    let mealsViewModel = MealsViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.register(UINib(nibName: "RestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        homeScreen.getUserName()
        homeScreen.fetchRestaurants()
        
        homeScreen.closure = {
            self.emptyArr = self.homeScreen.restaurantList
            
            self.restaurantCategories = self.emptyArr
            print(self.restaurantCategories)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
        
    }
    
}
extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealsViewModel.categories.count
    }
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: HomeScreenFoodCollectionViewCell.identifier,
                                                   for: indexPath)
                as? HomeScreenFoodCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(category: mealsViewModel.categories[indexPath.row])
        return cell 
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mealName = mealsViewModel.categories[indexPath.row].name
        
        switch FoodCategories(rawValue: mealName) {
        case .all:
            restaurantCategories = emptyArr
        case .asian:
            restaurantCategories = emptyArr.filter { $0.category == mealName || $0.category == "Asian" }
        case .beverages:
            restaurantCategories = emptyArr.filter { $0.category == mealName || $0.category == "Beverages" }
        case .pizza:
            restaurantCategories = emptyArr.filter { $0.category == mealName || $0.category == "Pizza" }
                   print(emptyArr)
        case .fastfood:
            restaurantCategories = emptyArr.filter { $0.category == mealName || $0.category == "Fast Food" }
            print(restaurantCategories)
        case .continental:
            restaurantCategories = emptyArr.filter { $0.category == mealName || $0.category == "Continental" }
        default:
            restaurantCategories = emptyArr
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier:
                                                            "cell", for: indexPath)
                as? RestaurantsTableViewCell else {return UITableViewCell()
            
        }
        
        cell.setup(with: restaurantCategories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = homeScreen.restaurantList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = UIStoryboard(name: "Details", bundle: nil)
                .instantiateViewController(identifier: "DetailsVC")
                as? DetailsViewController else {return}
        viewController.detailViewModel.passRestaurantName = detail.restaurantName
        viewController.detailViewModel.passRestaurantDiscount = detail.discountLabel
        viewController.detailViewModel.restID = homeScreen.restaurantIDS[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
