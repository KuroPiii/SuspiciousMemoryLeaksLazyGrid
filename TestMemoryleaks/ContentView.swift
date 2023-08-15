//
//  ContentView.swift
//  TestMemoryleaks
//
//  Created by MacOS on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack {
            TabView(action1: { [weak viewModel] in
                viewModel?.isClicked = true
            }, action2: { [weak viewModel] in
                viewModel?.isClicked = false
            })
            .offset(y: 200)
            
            ScreenView1(drawRadioButtonViewModel: DrawRadioButtonViewModel1())
                .opacity(viewModel.isClicked ? 0: 1)
            
            TravelingView1()
                .opacity(viewModel.isClicked ? 1 : 0)
            
        }.edgesIgnoringSafeArea(.top)
    }
}

class ViewModel: ObservableObject {
    @Published var isClicked: Bool = false
}
class DrawRadioButtonViewModel1: ObservableObject {
    @Published private(set) var isRadioCheck: Bool = false

    func updateToggleCheck() {
        self.isRadioCheck.toggle()
    }
}

struct TabView: View {
    let action1: () -> Void
    let action2: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action1()
            } label: {
                Text("Tab 1")
            }
            Button {
                action2()
            } label: {
                Text("Tab 2")
            }
        }
    }
}

struct TravelingView1: View {
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    ForEach(0..<10) {_ in
                        Rectangle()
                            .frame(height: 20)
                    }
                }
            }
            .frame(height: 200)
    }
}

struct ScreenView1: View {
    @ObservedObject var drawRadioButtonViewModel: DrawRadioButtonViewModel1
    var body: some View {
        RadioButton(type: .radioButton, toggle: drawRadioButtonViewModel.isRadioCheck,
                    identifier: "Quick Split",
                    radioWidth: 302,
                    action: { [weak drawRadioButtonViewModel] in
            drawRadioButtonViewModel?.updateToggleCheck()
        },
                    label: {})
        .offset(x: -CGFloat(100)/2, y: CGFloat(100))
        
        Button(drawRadioButtonViewModel.isRadioCheck ? "Checked" : "Unchecked", action: { [weak drawRadioButtonViewModel] in
            drawRadioButtonViewModel?.updateToggleCheck()
        })
            .offset(x: -CGFloat(100)/2, y: CGFloat(100) + 30)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
