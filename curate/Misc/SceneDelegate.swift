//import UIKit
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate,
//SPTAppRemoteDelegate, UIApplicationDelegate, ObservableObject{
//
//    static private let kAccessTokenKey = "access-token-key"
//    private let redirectUri = URL(string:"curate://")!
//    private let clientIdentifier = "30d5873028d143c8aea897d5b319c60e"
//
//    var window: UIWindow?
//
//    lazy var appRemote: SPTAppRemote = {
//        let configuration = SPTConfiguration(clientID: self.clientIdentifier, redirectURL: self.redirectUri)
//        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
//        appRemote.connectionParameters.accessToken = self.accessToken
//        appRemote.delegate = self
//        return appRemote
//    }()
//
//    var accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {
//        didSet {
//            let defaults = UserDefaults.standard
//            defaults.set(accessToken, forKey: SceneDelegate.kAccessTokenKey)
//        }
//    }
//
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        guard let url = URLContexts.first?.url else {
//            return
//        }
//
//        let parameters = appRemote.authorizationParameters(from: url);
//
//        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//            appRemote.connectionParameters.accessToken = access_token
//            self.accessToken = access_token
//        } else if let _ = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            // Show the error
//        }
//
//    }
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = scene as? UIWindowScene else { return }
//
//        // Create a new UIWindow instance
//        let window = UIWindow(windowScene: windowScene)
//
//        // Set the window's root view controller
//        window.rootViewController = ViewController()
//        
//        // Assign the created UIWindow to the window property of the SceneDelegate
//        self.window = window
//
//        // Make the window visible
//        window.makeKeyAndVisible()
//    }
//
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        connect();
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        playerViewController.appRemote.disconnect()
//        appRemote.disconnect()
//    }
//
//    func connect() {
//        playerViewController.appRemote.connect()
//        appRemote.connect()
//    }
//
//    // MARK: AppRemoteDelegate
//
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//        self.appRemote = appRemote
//        print("connected")
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//        print("didFailConnectionAttemptWithError")
//        playerViewController.appRemote.disconnect()
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//        print("didDisconnectWithError")
//        playerViewController.appRemote.disconnect()
//    }
//
//    var playerViewController: ViewController {
//        get {
////            let window = self.window
////            let rvc = window?.rootViewController
////            let childs = rvc?.children
////            let navController = rvc as! UINavigationController
////            return navController.topViewController as! ViewController
//            return ViewController()
//        }
//    }
//
//
//
//
//}
