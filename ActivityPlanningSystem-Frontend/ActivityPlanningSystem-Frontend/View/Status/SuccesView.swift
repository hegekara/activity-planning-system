//
//  SuccesView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 23.02.2025.
//

import SwiftUI

struct SuccesView: View {
    var body: some View {
        VStack{
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundStyle(.green)
                .padding()
                
            Text("Procces successfully completed")
                .fontWeight(.semibold)
                .font(.title)
            
        }
    }
}

#Preview {
    SuccesView()
}
