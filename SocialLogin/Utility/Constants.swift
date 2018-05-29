//
//
//  Created by WOS on 29/11/17.
//  Copyright © 2017 WOS. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let App_Name                             = "Social Login"
    
    // MARK: - Storyboard
    static let Storyboard_Main                      = "Main"
    
    //vyasbhagat@gmail.com |
    //static let Google_SignIn_ClientID                = ("232833577432-ogtgaq5j5to2jdbqa2u6uevcl1m6ncve.apps.googleusercontent.com")
    
    //wos.test999@gmail.com | qwertyhn
    static let Google_SignIn_ClientID                = ("925372937022-igshriimft74k25025snbmdnusp248p9.apps.googleusercontent.com")
    
    //vyasbhagat@gmail.com |
    static let Twitter_SignIn_ConsumerKey = ("pQW7czv4KtDrs3sTDsEnTd1tr")
    static let Twitter_SignIn_ConsumerSecret  = ("IJI1gPyHWY65zwW6vQXbYiQRP1L1H4OzntMa2DbWPMTxcGOEAN")
    static let Twitter_SignIn_CallbackURL = ("http://whiteorangesoftware.com/")
    static let Twitter_SignIn_AppOnlyAuthentication = ("https://api.twitter.com/oauth2/token")
    static let Twitter_SignIn_RequestTokenURL = ("https://api.twitter.com/oauth/request_token")
    static let Twitter_SignIn_AuthorizeURL = ("https://api.twitter.com/oauth/authorize")
    static let Twitter_SignIn_AccessTokenURL = ("https://api.twitter.com/oauth/access_token")
    
    //vyasbhagat@gmail.com |
    static let Instagram_SignIn_ClientID = ("e4b31fa0b66c429ab8a7a1da304990dd")
    static let Instagram_SignIn_ClientSecret = ("f49f20922cfe4c2fb0e93db97682de2c")
    
    static let Instagram_SignIn_AuthURL = ("https://api.instagram.com/oauth/authorize/")
    static let Instagram_SignIn_RedirectURI = ("http://www.google.com")
    static let Instagram_SignIn_ACCESS_TOKEN = ("access_token")
    static let Instagram_SignIn_SCOPE = ("follower_list+public_content") /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
    static let Instagram_getLoginUser_ProfileData = ("https://api.instagram.com/v1/users/self/?access_token=")
    
    //vyasbhagat@gmail.com |
    static let LinkedIn_SignIn_ClientID = ("81l8cvgy8aktd9")
    static let LinkedIn_SignIn_ClientSecret = ("uYzOy2TAeKgqurcj")
    //static let LinkedIn_AuthorizedRedirectURLs = ("https://www.google.com")
    static let LinkedIn_AuthorizedRedirectURLs = ("https://com.appcoda.linkedin.oauth/oauth")
    static let LinkedIn_Default_Accept_RedirectURL = ("https://www.google.com")
    static let LinkedIn_Default_Cancel_RedirectURL = ("https://www.google.com")
    
    static let LinkedIn_SignIn_Authorization_URL = ("https://www.linkedin.com/uas/oauth2/authorization")
    static let LinkedIn_SignIn_AccessToken_URL = ("https://www.linkedin.com/uas/oauth2/accessToken")
    
    // Specify the response type which should always be "code".
    static let LinkedIn_SignIn_responseType = "code"
    
    // Create a random string based on the time interval (it will be in the form linkedin12345679).
    static let LinkedIn_SignIn_state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
    
    // Set preferred scope.
    static let LinkedIn_SignIn_scope = "r_basicprofile"
    
    // MARK: - Static URL
    static let URL_Static_None : NSString = ""
    static let URL_Static_Google : NSString = "https://www.google.co.in/"
    
    //MARK: - Static Message
    static let MESSAGE_SomethingWasWrong = "Something was wrong"
    static let MESSAGE_WorkingProgress = "Working Progress..."
    
    // MARK: - Some Static Key's
    static let key_LoginType:NSString = "logintype"
    static let key_google:NSString = "key_google"
    static let key_facebook:NSString = "key_facebook"
    static let key_twitter:NSString = "key_twitter"
    static let key_instagram:NSString = "key_instagram"
    static let key_linkedin:NSString = "key_linkedin"
}
