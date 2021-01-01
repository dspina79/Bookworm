//
//  EnvironmentUsage.swift
//  Bookworm
//
//  Created by Dave Spina on 12/31/20.
//

import SwiftUI

struct EnvironmentUsage: View {
    // size classes are environment variables like presentaiton mode
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        // AnyvView is a type erasure to overcome the issue where the system
        // must return the same View type on the top level
        
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active Size Class")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active Size Class")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct EnvironmentUsage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EnvironmentUsage()
            EnvironmentUsage()
        }
    }
}
