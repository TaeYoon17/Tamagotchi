//
//  SceneDelegate.swift
//  Tamagotchi
//
//  Created by 김태윤 on 2023/08/04.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene) // window를 코드로 다룰 수 있도록 변환
        UIView.appearance().backgroundColor = .background
        UILabel.appearance().textColor = .accentColor
        let user:User? = UserDefaults.standard.object(forKey: "User") as? User
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let user = user{
            User.initUser(user: user)
            guard let vc = sb.instantiateViewController(withIdentifier: MainVC.identifier) as? MainVC else { return }
            window?.rootViewController = vc
        }else{
            guard let vc = sb.instantiateViewController(withIdentifier: SelectVC.identifier) as? SelectVC else { return }
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible() // 아이폰에서 보게 해주세요.
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

