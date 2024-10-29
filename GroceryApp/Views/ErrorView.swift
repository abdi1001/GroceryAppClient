//
//  ErrorView.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/28/24.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack {
            Text("Error has occured in the application.")
                .font(.headline)
                .padding([.bottom], 10)
            Text(errorWrapper.error.localizedDescription)
            Text(errorWrapper.guidance)
                .font(.caption)
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum SampleError: Error {
        case oprationFailed
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: ErrorWrapper(error: SampleError.oprationFailed, guidance: "Operation has failed. Please try again later."))
    }
    

}
