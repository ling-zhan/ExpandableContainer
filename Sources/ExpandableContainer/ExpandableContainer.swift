import SwiftUI

@available(iOS 14.0, *)
public struct ExpandableContainer<Header: View, Content: View>: View {
    public let header: Header
    public let content: Content
    @Binding var isExpanding: Bool
    public var tag: Int?
    public var selectedTag: ((Int) -> Void)?
    public init(
        @ViewBuilder header: @escaping() -> Header,
        @ViewBuilder content: @escaping() -> Content,
        isExpanding: Binding<Bool>,
        tag: Int? = nil,
        selectedTag:  ((Int) -> Void)? = nil) {
        self.header = header()
        self.content = content()
        self._isExpanding = isExpanding
        self.tag = tag
        self.selectedTag = selectedTag
    }
    public var body: some View {
        VStack(spacing: 0) {
            self.header
                .onTapGesture(perform: {
                    withAnimation(.spring()) {
                        self.isExpanding.toggle()
                        if selectedTag != nil && tag != nil {
                            self.selectedTag!(self.tag!)
                        }
                    }
                })
            if isExpanding {
                Divider()
                    .opacity(isExpanding ? 1 : 0)
                    .padding(.vertical)
                self.content
            }
        }
    }
}
