//
//  WebServices.swift
//  GlobalAPICall
//
//  Created by Ravi on 06/07/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire
import SwiftyJSON

let MESSAGE_Err_Network = "Please check network connections. try again."

class WebServices: NSObject
{
    func CallGlobalAPI(url:String, headers:HTTPHeaders,parameters:NSDictionary, HttpMethod:String, call_webService_using_formData_Method: Bool, ProgressView:Bool, responseDict:@escaping ( _ jsonResponce:JSON ) -> Void )  {
        
        //Loader Required or Not
        if ProgressView == true {
            //self.ProgressViewShow()
            //MyFunction().loader_show()
        }
        
        //Internet Checking
        //if internetChecker(reachability: Reachability()!) {
            if (HttpMethod == "POST") {
                var req = URLRequest(url: try! url.asURL())
                req.httpMethod = "POST"
                req.allHTTPHeaderFields = headers
                req.setValue("application/json", forHTTPHeaderField: "content-type")
                
                //Manage WebService Called Type
                if (call_webService_using_formData_Method == true) {
                    req.setValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
                    
                    //let postString = self.getPostString(params: parameters as! [String : Any])
                    //req.httpBody = postString.data(using: .utf8)
                }
                else {
                    req.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
                }
                req.timeoutInterval = 30 // 10 secs
                
                Alamofire.request(req).responseJSON { response in
                    //self.ProgressViewHide()
                    //MyFunction().loader_hide()
                    
                    print("URL: \n\(url)")
                    print("Headers: \n\(headers)")
                    print("Parameters: \n\(parameters)")
                    
                    if((response.result.value) != nil) {
                        let jsonResponce = JSON(response.result.value!)
                        print("Responce: \n\(jsonResponce)")
                        
                        DispatchQueue.main.async {
                            //self.ProgressViewHide()
                            responseDict(jsonResponce)
                        }
                    }
                    else {
                        print("Error: \n\(String(describing: response.result.error))")
                        
                        let jsonError = JSON(response.result.error!)
                        DispatchQueue.main.async {
                            responseDict(jsonError)
                        }
                    }
                }
            }
            else if (HttpMethod == "GET") {
                var req = URLRequest(url: try! url.asURL())
                req.httpMethod = "GET"
                //req.allHTTPHeaderFields = headers //---> Set header , Cuter Not check it
                req.setValue("application/json", forHTTPHeaderField: "content-type")
                req.timeoutInterval = 30 // 10 secs
                
                Alamofire.request(req).responseJSON { response in
                    
                    //self.ProgressViewHide()
                    //MyFunction().loader_hide()
                    
                    print("URL: \n\(url)")
                    print("Headers: \n\(headers)")
                    print("Parameters: \n\(parameters)")
                    if((response.result.value) != nil) {
                        let jsonResponce = JSON(response.result.value!)
                        print("Responce: \n\(jsonResponce)")
                        
                        DispatchQueue.main.async {
                            //self.ProgressViewHide()
                            responseDict(jsonResponce)
                        }
                    }
                    else {
                        print("Error: \n\(String(describing: response.result.error))")
                        
                        let jsonError = JSON(response.result.error!)
                        DispatchQueue.main.async {
                            //self.ProgressViewHide()
                            responseDict(jsonError)
                        }
                    }
                }
            }
        }
        /*
        else {
            //self.ProgressViewHide()
            //MyFunction().loader_hide()
            self.showAlertMessage(titleStr: "Error!", messageStr: MESSAGE_Err_Network)
        }*/
    }
    

    /*func internetChecker(reachability: Reachability) -> Bool {
        // print("\(reachability.description) - \(reachability.connection)")
        var check:Bool = false
        
        if reachability.connection == .wifi {
            check = true
        }
        else if reachability.connection == .cellular {
            check = true
        }
        else
        {
            check = false
        }
        return check
    }
    */
    func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    // MARK: ProgressView
    func ProgressViewShow() {
        DispatchQueue.main.async {
            //NotificationCenter.default.post(name: Notification.Name("loaderStart"), object: nil)
            
            //SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
            //SVProgressHUD.show(withStatus: "Processing...") // Simple Show Loader with Loading Message
            
            //MyFunction().loader_show()
        }
    }
    
    func ProgressViewHide() {
        DispatchQueue.main.async {
            //NotificationCenter.default.post(name: Notification.Name("loaderStop"), object: nil)
            //SVProgressHUD.dismiss()
        }
    }
    
    func showAlertMessage(titleStr:String, messageStr:String) -> Void {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert);
            
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            //Set Auto Hide Alert
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                alert.dismiss(animated: true, completion:nil)
            }
            UIApplication.shared.delegate?.window!?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

