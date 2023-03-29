//
//  AppDelegate.swift
//  REFIT
//
//  Created by 김동윤 on 2022/09/12.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData
import GoogleSignIn

import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase 초기화
        FirebaseApp.configure()
        
        // tap bar 선 긋기
        let tapBarAppearance = UITabBarAppearance()
                tapBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().standardAppearance = tapBarAppearance
                UITabBar.appearance().scrollEdgeAppearance = tapBarAppearance
        
        // 네트워크 확인
        NetworkCheck.shared.startMonitoring()
        return true
    }
    
    func application (
        _ application: UIApplication,
        open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]
    ) -> Bool {
        // 구글의 인증 프로세스가 끝날 때 앱이 수신하는 url 처리
        return GIDSignIn.sharedInstance.handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


