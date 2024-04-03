//
//  DataPullJson.swift
//  VoicedApp
//
//  Created by Abraham Morales Arroyo on 4/2/24.
//

import SwiftUI
import Foundation

struct DataPullJson: View {
    
    

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        UIViewController
    }
}

#Preview {
    DataPullJson()
}


extension UIViewController{
    func getData(from url: String){
      let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
          guard let data = data, error == nil else {
              print("something went wrong ")
              return
          }
          // have data
          // convert the data here.
          var result: Response?
          do{
              result = try JSONDecoder().decode(Response.self, from: data)
          } catch {
              print("failed to convert \(error.localizedDescription)")
          }
          guard let json = result else {
              return
          }
          // we print out some of the values
          print(json.results.SR_TYPE)
          print(json.results.Community_Area)
          print(json.results.status)
      })
      task.resume()
   }
}
