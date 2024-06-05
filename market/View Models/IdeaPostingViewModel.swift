//
//  IdeaPostingViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 12/4/23.
//

import Foundation

class IdeaPostingViewModel: ObservableObject {
    func postIdea(title: String, body: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://your-backend-url/api/ideas") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let ideaData = ["title": title, "body": body]
        request.httpBody = try? JSONSerialization.data(withJSONObject: ideaData, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error posting idea: \(error)")
                return
            }
            // Handle the response here
        }.resume()
    }
}
