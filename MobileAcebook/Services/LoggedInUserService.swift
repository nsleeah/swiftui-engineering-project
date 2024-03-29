//
//  LoggedInUserService.swift
//  MobileAcebook
//
//  Created by Amy McCann on 21/02/2024.
//

import Foundation
import PhotosUI

class LoggedInUser: ObservableObject {
    @Published var user: User?


    var token = retrieveTokenFromKeychain()?.token

    
    
    
    func fetchUser() {
        if let url = URL(string: "http://127.0.0.1:8080/posts") {
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let result = try? JSONDecoder().decode(Item.self, from:data) {
                    DispatchQueue.main.async {
                        self.user = result.user
                    }
                }
            }.resume()
        } else {
            print("Invalid URL")
        }
    }
}



