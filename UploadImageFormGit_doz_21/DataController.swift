//
//  DataController.swift
//  UploadImageFormGit_doz_21
//
//  Created by Student on 22.09.23.
//

import Foundation
import SwiftUI

class DataController:ObservableObject{
    
    
    @Published var responseStr:String = ""
    
    func uploadToServer(uiImage:UIImage,filename:String){
        //wandel BildObjekt in Daten um ...dabei komprimiere das Bild wenn gewünscht
        let imageData: Data = uiImage.jpegData(compressionQuality: 0.5) ?? Data()
        //wandel die ImageDaten in eine String um mit base64
        let imageStr: String = imageData.base64EncodedString()
        //print(imageStr)
        //wohin soll der String gesendet
        guard let url: URL = URL(string: "http://51.20.52.32/alex/imageupload/saveimage.php") else {
            print("invalid URL")
            return
        }
        
        // create parameters
        let paramStr: String = "image=\(imageStr)&newname=\(filename)"
        let paramData: Data = paramStr.data(using: .utf8) ?? Data()
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = paramData
        
        // required for sending large data
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // send the request
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else {
                print("invalid data")
                return
            }
            
            // show response in string
            DispatchQueue.main.async {
                self.responseStr = String(data: data, encoding: .utf8) ?? ""
                print(self.responseStr)
            }
            
        })
        .resume()
        
        
    }
    
    
    
}
