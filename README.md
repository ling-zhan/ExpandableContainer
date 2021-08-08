# ExpandableContainer(可上傳了!! 用自已的上傳即可)
![avatar](/preview01.gif)
![avatar](/preview02.gif)

一個可擴展的 SwiftUI 套件
  - 可自由定義畫面
  - 可自行設定列表中各體擴展或群組式的可擴展元件

### 版本要求
  -  Xcode 12
  -  iOS 14 以上

### 安裝
在 Xcode 中:
  - 到 **File > Swift Packages > Add Package Dependency**
  - 然後貼上 github 網址：https://github.com/ling-zhan/TabBar-SwiftUI
  - 接下來按 **Next > Branch: master > Next > Finish**
  - 成功的把套件匯進你的專案了
   
 ### 如何使用
  - 匯入 ExpandableContainer
  - 使用 ExpandableContainer 創建可擴展元件

### 例子
```sh

import ExpandableContainer

```
### 可擴展元件
```sh

ScrollView {
    LazyVStack(spacing: 20) {
            ForEach(0..<vm.articles.count, id: \.self) { index in
                ExpandableContainer(header: {
                    HStack(spacing:0) {
                        Text(vm.articles[index].title)
                            .lineLimit(2)
                            .font(.body.bold())
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(
                                vm.articles[index].isExpanding ? .degrees(180) : .zero)
                    }
                }, content: {
                    Text(vm.articles[index].content)
                        .font(.body)
                }, isExpanding: $vm.articles[index].isExpanding)
                .modifier(listModifier())
            } // end ForEach
    } // end LazyVStack
} // end ScrollView

```

### 單一展開

```sh

@State var selected: Int = 0

...

ScrollView {
    LazyVStack(spacing: 20) {
        ForEach(0..<vm.groupArticles.count, id: \.self) { index in
            ExpandableContainer(header: {
                HStack(spacing:0) {
                    Text(vm.groupArticles[index].title)
                        .lineLimit(2)
                        .font(.body.bold())
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(
                            vm.groupArticles[index].isExpanding ? .degrees(180) : .zero)
                }
            }, content: {
                Text(vm.groupArticles[index].content)
                    .font(.body)
            },isExpanding: $vm.groupArticles[index].isExpanding,
            tag: index,
            selectedTag: { tag in self.selected = tag })
            .onChange(of: selected, perform: { value in
                withAnimation(.spring()) {
                    if value != index {
                        vm.groupArticles[index].isExpanding = false
                    }
                }
            })
            .modifier(listModifier())
        }.onAppear(perform: {
            vm.groupArticles[selected].isExpanding = true
        })
    } // end LazyVStack
} // end ScrollView

```

完整範例檔 [ExpandableContainerDemo](https://) 

 ### 授權
MIT

