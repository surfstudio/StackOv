//
//  PageButton.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette

public struct PageButton: View {
    
    @Binding var currentPage: UUID
    private let model: PageModel
    
    @State private var hovered = false
    
    public init(_ model: PageModel, currentPage: Binding<UUID>) {
        self.model = model
        self._currentPage = currentPage
    }
    
    public var body: some View {
        ZStack(alignment: .trailing) {
            Button(action: { print("choose"); currentPage = model.id }) {
                HStack(alignment: .center, spacing: .zero) {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .frame(width: 6, height: 6)
                        .foregroundColor(Color.foreground)
                    
                    Text(model.title ?? "New page")
                        .foregroundColor(Color.foregroundText)
                        .font(.system(size: 11, weight: .medium))
                        .padding(.leading, 6)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .frame(height: 28)
                .padding(EdgeInsets(top: .zero, leading: 10, bottom: .zero, trailing: 20))
            }
            .disabled(currentPage == model.id)
            .buttonStyle(PageButtonStyle(id: model.id, currentPage: $currentPage))
            
            CloseButton {
                print("click \(model.id)")
            }
            .hoverEffect(.lift)
        }
    }
}

fileprivate struct CloseButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: .zero) {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 7, height: 7)
                    .foregroundColor(Color.foreground)
            }
            .frame(height: 28)
            .padding(EdgeInsets(top: .zero, leading: 3, bottom: .zero, trailing: 10))
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Previews

struct PageButton_Previews: PreviewProvider {
    
    static var previews: some View {
        let model = PageModel(title: "Test Page")
        PageButton(model, currentPage: .constant(model.id))
            .padding()
            .background(Color(red: 0.122, green: 0.125, blue: 0.133))
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Button styles

struct PageButtonStyle: ButtonStyle {
    
    let id: UUID
    @Binding var currentPage: UUID
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(idealWidth: 190, maxWidth: 190)
            .background(Color.background(by: configuration.isPressed || currentPage == id))
            .cornerRadius(6)
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let foreground = Palette.dullGray
    static let foregroundText = Palette.gainsboro
    static func background(by pressed: Bool) -> Color {
        pressed ? Palette.white.opacity(0.1) : Palette.white.opacity(0.06)
    }
}
