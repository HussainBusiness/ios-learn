//
//  AppDelegate.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 06/10/2022.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    
   
    

   var window: UIWindow?
   let loginViewController = LoginViewController()
   let onboardingContainerViewController = OnboardingContainerViewController()
  // let dummyViewController = DummyViewController()
   let mainViewController = MainViewController()
   var hasOnboarded = false
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
     //   dummyViewController.logoutDelegate = self
        
      //  window?.rootViewController = onboardingContainerViewController
        
        displayLogin()
    
      //  mainViewController.selectedIndex = 1
        
        return true
    }
    
    private func displayLogin(){
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnboarded{
            prepMainView()
            setRootViewController(mainViewController)
        }else{
            setRootViewController(onboardingContainerViewController)
        }
        
    }
    
    private func prepMainView(){
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
    
    
}

extension AppDelegate: LoginViewControllerDelgate{
  
    func didLogin() {
        displayNextScreen()
    }
    
    
}

extension AppDelegate: OnboardingContainerViewControllerDelgate{
    func didFinishOnboarding() {
        prepMainView()
        setRootViewController(mainViewController)
    }
    
    
}

extension AppDelegate: LogoutDelegate{
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate{
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true){
        
        guard animated, let window = self.window else{
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }
}



