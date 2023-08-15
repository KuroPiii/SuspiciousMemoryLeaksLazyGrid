//
//  Button.swift
//  EasySettingBox
//
//  Created by Admin on 13/12/CGFloat(20)22.
//

import Foundation
import SwiftUI

struct RadioButton<Content: View>: View {
    let type: Button_styles
    let toggle: Bool
    var isDisable: Bool = false
    let identifier: String
    var radioWidth: Int
    let action: () -> Void
    let label: () -> Content

    enum Button_styles {
        case radioButton
        case checkBox
    }

    init(type: Button_styles, toggle: Bool, isDisable: Bool = false, identifier: String, radioWidth: Int, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Content) {
        self.type = type
        self.action = action
        self.radioWidth = radioWidth
        self.label = label
        self.toggle = toggle
        self.isDisable = isDisable
        self.identifier = identifier
    }

    init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Content) {
        self.init(type: .radioButton, toggle: Bool(), isDisable: Bool(), identifier: String(), radioWidth: Int(), action: action, label: label)
    }

    var body: some View {
        Button(action: action, label: label)
            .buttonStyle(RadioButtonStyle(toggle: toggle,
                                          isDisable: isDisable,
                                          identifier: identifier,
                                          radioWidth: radioWidth,
                                          action: action))
        
    }
}

struct RadioButtonStyle: ButtonStyle {
    var toggle: Bool
    var isDisable: Bool
    var identifier: String
    var radioWidth: Int
    var action: () -> Void
    func makeBody(configuration _: Configuration) -> some View {
        ZStack {
            if isDisable {
                DisableRadioButton(identifier: identifier, radioWidth: radioWidth, action: action)
            } else {
                if toggle {
                    SelectedRadioButton(identifier: identifier, radioWidth: radioWidth, action: action)
                } else {
                    NormalRadioButton(identifier: identifier, radioWidth: radioWidth, action: action)
                }
            }
        }
    }
}

struct SelectedRadioButton: View {
    var identifier: String
    var radioWidth: Int
    var action: () -> Void
    var body: some View {
        let offsetX = radioWidth / 2 + 20/2 + 12
        ZStack {
            Image("common_check_on")
                .frame(width: CGFloat(20), height: CGFloat(20))
            Text(identifier)
                .shadow(color: .black.opacity(0.75), radius: 1, x: 1, y: 1)
                .font(.system(size: 15))
                .frame(width: CGFloat(radioWidth), height: CGFloat(20), alignment: .leading)
                .offset(x: CGFloat(offsetX), y: 0)
                .foregroundColor(.black)
                .onTapGesture {
                    action()
                }
        }
    }
}

struct NormalRadioButton: View {
    var identifier: String
    var radioWidth: Int
    var action: () -> Void
    var body: some View {
        let offsetX = radioWidth / 2 + 20/2 + 12
        ZStack {
            Image("common_check_off")
                .frame(width: CGFloat(20), height: CGFloat(20))
            Text(identifier)
                .shadow(color: .black.opacity(0.75), radius: 1, x: 1, y: 1)
                .font(.system(size: 15))
                .frame(width: CGFloat(radioWidth), height: CGFloat(20), alignment: .leading)
                .offset(x: CGFloat(offsetX), y: 0)
                .foregroundColor(.black)
                .onTapGesture {
                    action()
                }
        }
    }
}

struct DisableRadioButton: View {
    var identifier: String
    var radioWidth: Int
    var action: () -> Void
    var body: some View {
        let offsetX = radioWidth / 2 + 20/2 + 12
        ZStack {
            Image("common_check_off")
                .frame(width: CGFloat(20), height: CGFloat(20))
            Text(identifier)
                .font(.system(size: 15))
                .frame(width: CGFloat(radioWidth), height: CGFloat(20), alignment: .leading)
                .offset(x: CGFloat(offsetX), y: 0)
                .foregroundColor(.gray)
                .onTapGesture {
                    action()
                }
        }
    }
}

