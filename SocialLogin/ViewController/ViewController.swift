//
//  ViewController.swift
//  SocialLogin
//
//  Created by WOS_MacMini_1 on 04/05/18.
//  Copyright © 2018 White Orange Software. All rights reserved.
//

import UIKit
import Foundation

import FacebookCore
import FacebookLogin
import GoogleSignIn
import TwitterKit
import TwitterCore

import SwiftyJSON

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, UIWebViewDelegate {

    // MARK: - Outlet
    @IBOutlet weak var lblLoginResponse_Title: UILabel!
    @IBOutlet weak var lblLoginResponse_Data: UILabel!
    
    @IBOutlet weak var lblLogin_Type: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var btnLoginNow: UIButton!
    
    @IBOutlet weak var viewInstagram: UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    // MARK: - Variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.manage_View()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Comman Function
    func manage_View() -> Void {
        self.manange_setResponse(respo_Title: "", respo_Data: "")
        self.manange_setLoginType(strTitle: "")
        self.manange_Loader(showLoader: false)
        
        //Hide WebView
        webView.delegate = self
        webView.layer.borderColor = UIColor.black.cgColor
        webView.layer.borderWidth = 1.0
        webView.layer.masksToBounds = true
        
        self.manange_Instagram(showView: false)
    }
    
    func manange_setResponse(respo_Title:NSString, respo_Data:NSString) -> Void {
        lblLoginResponse_Title.text = respo_Title as  String
        lblLoginResponse_Data.text = respo_Data as String
        
        //Set Font
        //self.lblLoginResponse_Data.font = UIFont.init(name: self.lblLoginResponse_Data.font.familyName, size: 14)
    }
    
    func manange_setLoginType(strTitle:NSString) -> Void {
        lblLogin_Type.text = strTitle as String
    }
    
    func manange_Loader(showLoader:Bool) -> Void {
        if (showLoader == true) {
            loader.startAnimating()
            loader.isHidden = false
        }
        else {
            loader.stopAnimating()
            loader.isHidden = true
        }
    }
    
    func manange_Instagram(showView:Bool) -> Void {
        if (showView == true) {
            viewInstagram.isHidden = false
        }
        else {
            viewInstagram.isHidden = true
        }
    }
    
    // MARK: - Button Click Action
    @IBAction func btnLoginNowAction() {
        self.view.endEditing(true) // Hide keyboard
        let alert = UIAlertController(title: Constants.App_Name, message: "Please Select an Option for Social Login", preferredStyle: .actionSheet)
 
        /*// LinkedIn Login------>
        alert.addAction(UIAlertAction(title: "LinkedIn", style: .default , handler:{ (UIAlertAction)in
            let ud : UserDefaults = UserDefaults.standard
            ud.set(Constants.key_linkedin, forKey: Constants.key_LoginType as String)
            ud.synchronize()
            
            //Implement this step by: https://www.appcoda.com/linkedin-sign-in/
            self.manage_View()
            self.loginNow_LinkedIn()
        }))*/
        
        // Instagram Login------>
        alert.addAction(UIAlertAction(title: "Instagram".uppercased(), style: .default , handler:{ (UIAlertAction)in
            let ud : UserDefaults = UserDefaults.standard
            ud.set(Constants.key_instagram, forKey: Constants.key_LoginType as String)
            ud.synchronize()
            
            //Implement this step by: https://wetalkit.xyz/instagram-api-authentication-using-swift-3bf27d7ed6aa
            self.manage_View()
            self.loginNow_Instagram()
        }))
        
        // Twitter Login------>
        alert.addAction(UIAlertAction(title: "Twitter".uppercased(), style: .default , handler:{ (UIAlertAction)in
            
            let ud : UserDefaults = UserDefaults.standard
            ud.set(Constants.key_twitter, forKey: Constants.key_LoginType as String)
            ud.synchronize()
            
            self.manage_View()
            self.loginNow_Twitter()
        }))
        
        // Google Login------>
        alert.addAction(UIAlertAction(title: "Google".uppercased(), style: .default , handler:{ (UIAlertAction)in
            
            let ud : UserDefaults = UserDefaults.standard
            ud.set(Constants.key_google, forKey: Constants.key_LoginType as String)
            ud.synchronize()
            
            self.manage_View()
            self.loginNow_Google()
        }))
        
        // Facebook Login------>
        alert.addAction(UIAlertAction(title: "Facebook".uppercased(), style: .default , handler:{ (UIAlertAction)in
            let ud : UserDefaults = UserDefaults.standard
            ud.set(Constants.key_facebook, forKey: Constants.key_LoginType as String)
            ud.synchronize()
            
            self.manage_View()
            self.loginNow_Facebook()
        }))
        
        /*
        // Reset------>
        alert.addAction(UIAlertAction(title: "Reset".uppercased(), style: .default , handler:{ (UIAlertAction)in
            self.manage_View()
        }))
        */
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        //Show Action Sheet
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnDismissAction() {
        self.manange_setResponse(respo_Title: "Instagram - Login Error", respo_Data:"The User cancelled the instagram sign-in flow.")
        self.manange_setLoginType(strTitle: "")
        self.manange_Loader(showLoader: false) // Hide Lader
        
        self.manange_Instagram(showView: false)
    }
    
    // MARK: - Facebook
    func loginNow_Facebook() {
        
        self.manange_setLoginType(strTitle: "Social Login - Facebook")
        self.manange_Loader(showLoader: true)
        
        let loginManager = LoginManager()
        loginManager.logOut()
        
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile, ReadPermission.email, .userBirthday, .userPhotos, .userEducationHistory], viewController: self) { loginResult in
            print("loginResult: \(loginResult)")
            switch (loginResult) {
            case .cancelled:
                let strErrMess: NSString = "The User cancelled the facebook sign-in flow."
                //print("strErrMess: \(strErrMess)")
                
                self.manange_setResponse(respo_Title: "Facebook - Login Error", respo_Data: strErrMess as NSString)
                self.manange_setLoginType(strTitle: "")
                self.manange_Loader(showLoader: false) // Hide Lader
                
            case .failed(let error):
                print("Facebook Login Error: \(error)")
                let strErrMess : String = error.localizedDescription
                
                self.manange_setResponse(respo_Title: "Facebook - Login Error", respo_Data: strErrMess as NSString)
                self.manange_setLoginType(strTitle: "")
                self.manange_Loader(showLoader: false) // Hide Lader
            case .success(let value):
                print("value: \(value)")
                self.loginNow_Facebook_using_GraphRequest()
            }
        }
    }
    
    func loginNow_Facebook_using_GraphRequest() {
        let arrGetData : NSMutableArray = []
        arrGetData.add("email")
        arrGetData.add("name")
        arrGetData.add("first_name")
        arrGetData.add("last_name")
        //arrGetData.add("gender")
        //arrGetData.add("birthday") //Not get values
        //arrGetData.add("age_range")
        //arrGetData.add("phone") //Get Error
        //arrGetData.add("cover")
        arrGetData.add("picture.type(large)")
        
        
        let getParameters = ["fields":arrGetData.componentsJoined(by: ",")]
        let request = GraphRequest(graphPath: "me", parameters: getParameters, accessToken: AccessToken.current,httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):
                print("Facebook Login Success: \(value.dictionaryValue! as [String:Any])")
                
                let getUserData = value.dictionaryValue
                self.manage_GetFacebookLogin_UserInfo(getUserData: getUserData! as NSDictionary)
            
            case .failed(let error):
                print("Facebook Login Error: \(error)")
                let strErrMess : String = error.localizedDescription
                
                self.manange_setResponse(respo_Title: "Facebook - Login Error", respo_Data: strErrMess as NSString)
                self.manange_setLoginType(strTitle: "")
                self.manange_Loader(showLoader: false) // Hide Lader
            }
        }
    }
    
    func manage_GetFacebookLogin_UserInfo(getUserData : NSDictionary) -> Void {
        let fbId: String = getUserData["id"] as! String
        let email: String = getUserData["email"] as! String
        let name: String = getUserData["name"] as! String
        let fname: String = getUserData["first_name"] as! String
        let lname: String = getUserData["last_name"] as! String
        //let gender: String = getUserData["gender"] as! String
        
        // Add this lines for get image
        let picture: NSDictionary = (getUserData["picture"] as? NSDictionary)!
        let data: NSDictionary = (picture["data"] as? NSDictionary)!
        let url: String = data["url"] as! String
        
        let strMess : String = "Facebook ID:\(fbId)\n\n" +
         "Email: \(email)\n\n" +
         "FullName:\(name)\n\n" +
         "Fname: \(fname)\n\n" +
         "Lname: \(lname)\n\n" +
         "profilePhotoURL: \(url)"
        
        self.manange_setResponse(respo_Title: "Facebook - Login Success", respo_Data: strMess as NSString)
        self.manange_setLoginType(strTitle: "")
        self.manange_Loader(showLoader: false) // Hide Lader
    }
    
    // MARK: - Google
    func loginNow_Google() {
        self.view.endEditing(true) // Hide Keyboard
        self.manange_setLoginType(strTitle: "Social Login - Google")
        self.manange_Loader(showLoader: true)
        
        GIDSignIn.sharedInstance().delegate = self as GIDSignInDelegate
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //self.present(viewController, animated: true, completion: nil)
        print("sign")
        
        if let error = error {
            print("error: \(error.localizedDescription)")
            let strErrMess : String = error.localizedDescription
            
            self.manange_setResponse(respo_Title: "Google - Login Error", respo_Data: strErrMess as NSString)
            self.manange_setLoginType(strTitle: "")
            self.manange_Loader(showLoader: false) // Hide Lader
        }
        else {
            // Perform any operations on signed in user here.
            let userId : String = user.userID
            //let idToken : String = user.authentication.idToken
            let fullName : String = user.profile.name
            let givenName : String = user.profile.givenName
            let familyName : String = user.profile.familyName
            let email : String = user.profile.email
            let profilePhotoURL : NSURL = user.profile.imageURL(withDimension: 512)! as NSURL
            
            let strMess : String = "Google+ ID: \(userId)\n.\n" +
                "Email: \(email)\n.\n" +
                "Full name: \(fullName)\n.\n" +
                "Fname: \(givenName)\n.\n" +
                "Lname: \(familyName)\n.\n" +
            "profilePhotoURL: \(profilePhotoURL)"
            print("strMess : \(strMess)")
            
            GIDSignIn.sharedInstance().disconnect()
            GIDSignIn.sharedInstance().signOut()
            
            self.manange_setResponse(respo_Title: "Google - Login Success", respo_Data: strMess as NSString)
            self.manange_setLoginType(strTitle: "")
            self.manange_Loader(showLoader: false) // Hide Lader
        }
    }
    
    // MARK: - Twitter
    func loginNow_Twitter() {
        self.view.endEditing(true) // Hide Keyboard
        self.manange_setLoginType(strTitle: "Social Login - Twitter")
        self.manange_Loader(showLoader: true)
        
       TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
        print("signed in session: \(String(describing: session))");
        print("signed in error: \(String(describing: error))");
            
            if (session != nil) {
                //print("signed in as \(session?.userName) | \(session?.userID)");
                let userID : String = (session?.userName)!
                let userName : String = (session?.userID)!
                
                //Get Login User Email
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    if (email != nil) {
                      print("signed in as \(String(describing: email))");
                    } else {
                      print("error: \(String(describing: error?.localizedDescription))");
                    }
                }
                
                //Get Login User All Details
                let request = client.urlRequest(withMethod: "GET",
                                  urlString: "https://api.twitter.com/1.1/account/verify_credentials.json",
                                  parameters: ["include_email": "true", "skip_status": "true"],
                                  error: nil)
                client.sendTwitterRequest(request) { (response, data, error) in
                  print("response: \(String(describing: response))")
                  print("data: \(String(describing: data))")
                  print("connectionError: \(String(describing: error))")
                    
                    //let json = JSON(data: data!)
                    let json = JSON(data!)
                   // print("json: \(json)")
                    
                    //-------------------->
                    //Show Data
                    let strMess : String = "Twitter ID: \(userID)\n" +
                    "User name: \(userName)\n" +
                    "Other Info: \(json.description)"
                    
                    self.manange_setResponse(respo_Title: "Twitter - Login Success", respo_Data: strMess as NSString)
                    self.manange_setLoginType(strTitle: "")
                    self.manange_Loader(showLoader: false)
                }
              
              //Get Login User All Details
              let requestSearch = client.urlRequest(withMethod: "GET",
                                              urlString: "https://api.twitter.com/1.1/search/tweets.json",
                                              parameters: ["q": "nar","lang":"en","locale":"in","count":"100"],
                                              error: nil)
              client.sendTwitterRequest(requestSearch) { (response, data, error) in
                print("response: \(String(describing: response))")
                print("data: \(String(describing: data))")
                print("connectionError: \(String(describing: error))")
                
                //let json = JSON(data: data!)
                let json = JSON(data!)
                print("Search Result: \(json)")
                
                //-------------------->
                //Show Data
                let strMess : String = "Twitter ID: \(userID)\n" +
                  "User name: \(userName)\n" +
                "Other Info: \(json.description)"
                
                self.manange_setResponse(respo_Title: "Twitter - Login Success", respo_Data: strMess as NSString)
                self.manange_setLoginType(strTitle: "")
                self.manange_Loader(showLoader: false)
              }
              
            }
            else {
              print("error: \(String(describing: error?.localizedDescription) ?? "")");
                
                let strErrMess : String = error!.localizedDescription
                self.manange_setResponse(respo_Title: "Twitter - Login Error", respo_Data: strErrMess as NSString)
                self.manange_setLoginType(strTitle: "")
                self.manange_Loader(showLoader: false) // Hide Lader
            }
        })
    }
    
    // MARK: - Instagram
    func loginNow_Instagram() {
        self.view.endEditing(true) // Hide Keyboard
        self.manange_setLoginType(strTitle: "Social Login - Instagram")
        self.manange_Loader(showLoader: true)
     
        //Load URL
        let authURL = "\(Constants.Instagram_SignIn_AuthURL)?client_id=\(Constants.Instagram_SignIn_ClientID)&redirect_uri=\(Constants.Instagram_SignIn_RedirectURI)&response_type=token&scope=\(Constants.Instagram_SignIn_SCOPE)&DEBUG=True"
        print("authURL: \(authURL)")
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        print("urlRequest: \(urlRequest)")
        
        webView.loadRequest(URLRequest.init(url: NSURL.init() as URL))
        webView.loadRequest(urlRequest)
        
        //Show WebView
        self.manange_Instagram(showView: true)
    }
    
    // MARK: WebView Delegate Method | Manage : Instagram and LinkedIn
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.manange_Loader(showLoader: true)
        self.lblLogin_Type.text = "Loading..."
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.manange_Loader(showLoader: false)
        self.lblLogin_Type.text = ""
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        return checkRequestForCallbackURL(request: request)
    }
    
    /*func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.manange_Loader(showLoader: false)
        
        print("didFailLoadWithError: \(error)")
        var errMess : NSString = error.localizedDescription as NSString
        errMess = "Error: \(errMess)" as NSString
        self.lblLogin_Type.text = errMess as String
    }*/
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        print("request: \(request)")
        
        let requestURLString = (request.url?.absoluteString)! as String
        let requestURL = request.url
        
        let ud : UserDefaults = UserDefaults.standard
        ud.value(forKey: Constants.key_LoginType as String)
        let value : NSString = ud.value(forKey: Constants.key_LoginType as String) as! NSString
        
        // Manage Instagram
        if (value.uppercased == Constants.key_instagram.uppercased) {
            if requestURLString.hasPrefix(Constants.Instagram_SignIn_RedirectURI) {
                let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
                
                handleAuth(authToken: requestURLString.substring(from: range.upperBound))
                return false;
            }
        }
        // Manage LinkedIn
        else if (value.uppercased == Constants.key_linkedin.uppercased) {
            if requestURLString.hasPrefix(Constants.LinkedIn_AuthorizedRedirectURLs) {
                let range : Range<String.Index> = (requestURL?.absoluteString.range(of: "code")!)!
                let accessToken = requestURLString.substring(from: range.upperBound)
                
                print("range: \(range)")
                print("accessToken: \(accessToken)")
                
                self.handle_AccessToken(authToken: accessToken)
            }
        }
        return true
    }
    
    func handleAuth(authToken: String) {
        print("authentication token: \(authToken)")
        
        //----------------------------->
        //Get User Info
        let strURL : NSString = "\(Constants.Instagram_getLoginUser_ProfileData)\(authToken)" as NSString
        
        WebServices().CallGlobalAPI(url: strURL as String, headers: [:], parameters: [:], HttpMethod: "GET", call_webService_using_formData_Method: false, ProgressView: false) { (jsonResponce: JSON) in
            print("\(strURL) response :\n\(jsonResponce)")
            
            let succMess : String = "Instagram authentication token : \(authToken)" +
                "\n.\n\(strURL) response :\n\(jsonResponce)"
            
            self.manange_setResponse(respo_Title: "Instagram - Login Success", respo_Data: succMess as NSString)
            self.manange_setLoginType(strTitle: "")
            self.manange_Loader(showLoader: false)
            self.manange_Instagram(showView: false)
        }
    }
    
    // MARK: - LinkedIn
    func loginNow_LinkedIn() {
        // Implement this step by: https://www.appcoda.com/linkedin-sign-in/
        
        self.view.endEditing(true) // Hide Keyboard
        self.manange_setLoginType(strTitle: "Social Login - LinkedIn")
        self.manange_Loader(showLoader: true)
        
        //Load URL
        var authorizationURL = "\(Constants.LinkedIn_SignIn_Authorization_URL)?"
        authorizationURL += "response_type=\(Constants.LinkedIn_SignIn_responseType)&"
        authorizationURL += "client_id=\(Constants.LinkedIn_SignIn_ClientID)&"
        authorizationURL += "redirect_uri=\(Constants.LinkedIn_AuthorizedRedirectURLs)&"
        authorizationURL += "state=\(Constants.LinkedIn_SignIn_state)&"
        authorizationURL += "scope=\(Constants.LinkedIn_SignIn_scope)"
        print("authorizationURL: \(authorizationURL)")
        
        let urlRequest = URLRequest.init(url: URL.init(string: authorizationURL)!)
        print("urlRequest: \(urlRequest)")
        
        webView.loadRequest(URLRequest.init(url: NSURL.init() as URL))
        webView.loadRequest(urlRequest)
        
        //Show WebView
        self.manange_Instagram(showView: true)
        
    }
    
    func handle_AccessToken(authToken: String) {
        print("handle_AccessToken token: \(authToken)")
        
        //----------------------------->
        //Get User Info
        let strURL : NSString = "\(Constants.LinkedIn_SignIn_AccessToken_URL)" as NSString
        let param : NSMutableDictionary = NSMutableDictionary.init()
        param.setValue("authorization_code", forKey: "grant_type")
        param.setValue(authToken, forKey: "code")
        param.setValue(Constants.LinkedIn_AuthorizedRedirectURLs, forKey: "redirect_uri")
        param.setValue(Constants.LinkedIn_SignIn_ClientID, forKey: "client_id")
        param.setValue(Constants.LinkedIn_SignIn_ClientSecret, forKey: "client_secret")
        
        print("postParams: \(param)")
        
        WebServices().CallGlobalAPI(url: strURL as String, headers: [:], parameters: [:], HttpMethod: "POST", call_webService_using_formData_Method: true, ProgressView: false) { (jsonResponce: JSON) in
            print("\(strURL) response :\n\(jsonResponce)")
            
            let succMess : String = "LinkedIn authentication token : \(authToken)" +
            "\n.\n.\n\(strURL) response :\n\(jsonResponce)"
            
            self.manange_setResponse(respo_Title: "LinkedIn - Login Success", respo_Data: succMess as NSString)
            self.manange_setLoginType(strTitle: "")
            self.manange_Loader(showLoader: false)
            self.manange_Instagram(showView: false)
        }
        
        //----------------------------->
        /*
        let grantType = "authorization_code"
        
        // Set the POST parameters.
        var postParams = "grant_type=\(grantType)&"
        postParams += "code=\(authToken)&"
        postParams += "redirect_uri=\(Constants.LinkedIn_AuthorizedRedirectURLs)&"
        //postParams += "redirect_uri=\(redirectURL)&"
        postParams += "client_id=\(Constants.LinkedIn_SignIn_ClientID)&"
        postParams += "client_secret=\(Constants.LinkedIn_SignIn_ClientSecret)"
        print("postParams: \(postParams)")
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.data(using: String.Encoding.utf8)
        
        // Initialize a mutable URL request object using the access token endpoint URL string.
        let request = NSMutableURLRequest(url: NSURL(string: Constants.LinkedIn_SignIn_AccessToken_URL)! as URL)
        
        // Indicate that we're about to make a POST request.
        request.httpMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.httpBody = postData
        
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")

        // Initialize a NSURLSession object.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // Make the request.
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            print("data: \(data)")
            print("response: \(response)")
            print("error: \(error)")
            
            //let json = JSON(data: data!)
            let json = JSON(data!)
            print("json: \(json)")
            
            //-------------------->
            //Show Data
            let succMess : String = "Other Info: \(json.description)"
            
            self.manange_setResponse(respo_Title: "LinkedIn - Login Success", respo_Data: succMess as NSString)
            self.manange_setLoginType(strTitle: "")
            self.manange_Loader(showLoader: false)
            self.manange_Instagram(showView: false)
        }
        task.resume()
        */
    }
}
