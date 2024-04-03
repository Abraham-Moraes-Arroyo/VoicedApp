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
        VStack{
            Text("Hello, World!")
            
            getanddisplay
        }
    }
}

#Preview {
    DataPullJson()
}
// based this solution on https://stackoverflow.com/questions/27050580/how-are-global-functions-defined-in-swift

extension getanddisplay{
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
