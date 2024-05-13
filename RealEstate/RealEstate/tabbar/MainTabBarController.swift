//import UIKit
//
//class MainTabBarController: UITabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let allViewVc = AllListingsViewController()
//        allViewVc.title = "Все объявления"
//        let allListingsViewController = UINavigationController(rootViewController: allViewVc)
//        allListingsViewController.tabBarItem = UITabBarItem(title: "Все объявления", image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 0)
//        
//        let userViewVc = UserListingsViewController()
//        userViewVc.title = "Объявления пользователя"
//        let userListingsViewController = UINavigationController(rootViewController: userViewVc)
//        userListingsViewController.tabBarItem = UITabBarItem(title: "Мои объявления", image: UIImage(systemName: "list.dash"), tag: 1)
//
//        
//        // Create an instance of CreateListingViewController
//        let createListingVC = AddListingViewController()
//        createListingVC.title = "Добавить" // Set a title for the tab
//        let addListingViewController = UINavigationController(rootViewController: createListingVC)
//        addListingViewController.tabBarItem = UITabBarItem(title: "Добавить", image: UIImage(systemName: "plus.square"), tag: 2)
//
//        
//        let chatViewVc = ChatViewController()
//        allViewVc.title = "Чат бот"
//        let chatViewController = UINavigationController(rootViewController: chatViewVc)
//        chatViewController.tabBarItem = UITabBarItem(title: "Чат бот", image: UIImage(systemName: "message.circle"), tag: 3)
//        
//        // Create an instance of MyProfileViewController
//        let myProfileVC = MyProfileViewController()
//        myProfileVC.title = "Мой профиль"
//        let myProfileNavigationController = UINavigationController(rootViewController: myProfileVC)
//        myProfileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 4)
//
//        
//
//        let usersViewVc = UsersViewController()
//        usersViewVc.title = "ghjdt"
//        let usersViewController = UINavigationController(rootViewController: usersViewVc)
//        usersViewController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "message.circle"), tag: 5)
//        
//        
//        
//        let adminViewVc = AdminPanelViewController()
//        adminViewVc.title = "ghjdt"
//        let adminPanelViewController = UINavigationController(rootViewController: adminViewVc)
//        adminPanelViewController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "message.circle"), tag: 6)
//        
//        
//        
//        
//
//        // Set the view controllers for the tab bar controller
//        viewControllers = [allListingsViewController,userListingsViewController,addListingViewController,chatViewController,myProfileNavigationController,usersViewController, adminPanelViewController]
//    }
//}


import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViewVc = AllListingsViewController()
        allViewVc.title = "All Listings"
        let allListingsViewController = UINavigationController(rootViewController: allViewVc)
        allListingsViewController.tabBarItem = UITabBarItem(title: "All Listings", image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 0)
        
        let userViewVc = UserListingsViewController()
        userViewVc.title = "User Listings"
        let userListingsViewController = UINavigationController(rootViewController: userViewVc)
        userListingsViewController.tabBarItem = UITabBarItem(title: "My Listings", image: UIImage(systemName: "list.dash"), tag: 1)

        let createListingVC = AddListingViewController()
        createListingVC.title = "Add"
        let addListingViewController = UINavigationController(rootViewController: createListingVC)
        addListingViewController.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.square"), tag: 2)

        let chatViewVc = ChatViewController()
        chatViewVc.title = "Chatbot"
        let chatViewController = UINavigationController(rootViewController: chatViewVc)
        chatViewController.tabBarItem = UITabBarItem(title: "Chatbot", image: UIImage(systemName: "message.circle"), tag: 3)

        let myProfileVC = MyProfileViewController()
        myProfileVC.title = "My Profile"
        let myProfileNavigationController = UINavigationController(rootViewController: myProfileVC)
        myProfileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 4)


        viewControllers = [allListingsViewController, userListingsViewController, addListingViewController, chatViewController, myProfileNavigationController]
    }
}
