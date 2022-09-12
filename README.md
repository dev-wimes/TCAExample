# TCACoordinator

이전 커밋&글: https://github.com/dev-wimes/TCAExample/tree/a335cd5bb4e616dc38e5d9e33ff17c063e81213b

## 개요

TCACoordinator를 사용해보려고 한다.
TCACoordinator를 사용하고자 하는 이유는 다음과 같은 pain point때문인데

* 화면이동 코드가 너무 지저분 하다.

  * NavigationLink를 사용하면 Declarative UI의 특성을 살릴 수 가 없다.

  * view에서 화면이동 action이 발생하면 action를 분리해서 처리해줄 수 없을까? 

  * TCA에서 현재 View에서 특정 View로 넘어갈 때 다음과 같은 코드를 작성해야 한다.

    ```swift
    NavigationView{
    	VStack{
      	Text(viewStore.resultString)
        NavigationLink {
        	A2View(store: Store(
          	initialState: A2State(resultString: ""),
            reducer: a2Reducer,
            environment: A2Environment(
            	request: {EffectsImpl().numbersApiThree()},
            	mainQueue: {.main}
            )))
    		} label: {
        	Text("open the A2 View")
        }
    	}
      .navigationTitle("A1")
    }
    ```

* Feature 또는 Package 내에서 Depth가 너무 깊어진다.

  * A에서 A1으로 이동하려면 A는 A1을 import 해줘야 한다. (A1, A2, A3, ... 도 마찬가지 import의 향연...)

    <img src="README.assets/image-20220912213458720.png" alt="image-20220912213458720" style="zoom:50%;" />

딱 떠오르는 패턴은 Coordinator 패턴이다.

화면의 이동을 Coordinator 해준다. View간의 이동에 대한 처리를 Coordinator가 맡아서 처리하고 (아래 코드처럼 버튼에 대한 action만 발생해주면 된다. 위 코드랑 비교해보면 얼마나 깔끔한가)

```swift
VStack {
  Text(viewStore.resultString)
  Button {
  	viewStore.send(.didTapButton)
   } label: {
   	Text("open the A2 View")
   }
}
.navigationBarTitle("A1", displayMode: .inline)
```

부모 피쳐에서는 자식 피쳐에 대한 정보를 알 필요가 없다. Coordinator가 알고 있으면 된다.(아까 코드를 보면 A2에 대한 정보가 필요 없다.)

<img src="README.assets/image-20220912214332660.png" alt="image-20220912214332660" style="zoom:50%;" />

## 설계 및 구현

아래와 같은 구조를 만드려고 한다.

![image-20220912215418460](README.assets/image-20220912215418460.png)

큰 Feature를 Coordinator로 묶고 피쳐간 의존성도 Coordinator로 결속?한다.
Coordinator가 Router라고 생각하면 이해가 쉽다.

우선 https://github.com/johnpatrickmorgan/TCACoordinators 에서 TCACoordinator를 Package에 추가해준다.

**Effects/Package.swift**

```swift
let package = Package(
    name: "Effects",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Effects", type: .dynamic, targets: ["Effects"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "0.36.0")
        ),
        .package(
            url: "https://github.com/johnpatrickmorgan/TCACoordinators",
            .upToNextMajor(from: "0.2.0")
        ),
    ],
    targets: [
        .target(
            name: "Effects",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCACoordinators", package: "TCACoordinators")
            ]),
        .testTarget(
            name: "EffectsTests",
            dependencies: ["Effects"]),
    ]
)
```



TCACoordinator의 구성은 다음과 같다.

* Interactor (State, Action, Reducer, view-less)
  * 피쳐의 State, Action, Reducer를 담고 있다. TCA기본 구성요소이므로 따로 설명은 필요없을 듯 하다.
* Screen (view-less)
  * 각 모듈들을 가져와서 리듀서를 만들어주고 관리해주기 위함
  * 따라서 View가 없다.
* Coordinator
  * 본격적으로 화면이동, 흐름을 관리해준다.
* View
  * CoordinatorView를 생성해 노출시켜준다.

다음으로 TCACoordinator의 실제 적용 예제를 볼텐데 구조가 단순하고 케이스가 그리 많지 않으니 Root 피쳐만 설명한다.

RootCoordinator는 Login과 TabBar를 포함한다. Login에서 특정 이벤트가 발생하면 TabBar로 화면이 넘어가도록 한다.

### Login

**LoginView**
는 버튼을 누르면 event발생시키는게 전부이다.

```swift
struct LoginView: View {
    
    let store: Store<LoginState, LoginAction>
    
    var body: some View {
        WithViewStore(self.store){ viewStore in
            VStack {
                Button {
                    viewStore.send(.loggedIn(loginData: "I'm Signed In!"))
                } label: {
                    Text("logIn")
                }
            }
        }
    }
}
```



**LoginInteractor**
에서는 로컬 이벤트(Login 내에서만 발생되고 처리되는 이벤트) 처리가 필요없기 때문에 reducer는 비어있다.

```swift
struct LoginState: Equatable { }

enum LoginAction {
    case loggedIn(loginData: String)
}

struct LoginEnvironmnet { }

let loginReducer: Reducer<
    LoginState,
    LoginAction,
    LoginEnvironmnet
> = Reducer { _, _, _ in
    return .none
}
```



### TabBar

**TabBarView**
의 특징은

* navigationView의 속성값 변경
* TabView를 통해 하위 피쳐들에 대한 접근

이다.

우선 TabBarView부터는 NavigationView를 사용한다.
TCACoordinator의 경우 내장되어 있는 프로퍼티를 통해 NavigationView를 사용하게 되는데
NavigationView를 커스텀할 수 있는지 알아보기 위해 구현해봤다.

```swift
init(store: Store<TabBarState, TabBarAction>) {
  self.store = store

  let navigationAppearance = UINavigationBarAppearance()
  navigationAppearance.configureWithTransparentBackground()
  navigationAppearance.backgroundColor = .systemRed

  UINavigationBar.appearance().standardAppearance = navigationAppearance
  UINavigationBar.appearance().compactAppearance = navigationAppearance
  UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
  UINavigationBar.appearance().tintColor = .black
}
```

우선은 navigation의 root(앱 전체의 Root를 의미하는 게 아님. NavigationStack에서 TabBar가 시작점이라 Root라 한 것.)에서는 Appearance정도 변경할 수 있는 것 같다.
위 코드를 작성하면 하위 navigation들에게 전부 영향을 받는다.

> **번외**
>
> App전체에 영향을 주고 싶다면 아래와 같은 방법을 쓰도록 하자
>
> ```swift
> import SwiftUI
> 
> extension UINavigationController {
>     open override func viewWillLayoutSubviews() {
>         super.viewWillLayoutSubviews()
>         navigationBar.topItem?.backButtonDisplayMode = .minimal
>     }
> }

body에는 TabView 내부에 A, B CoordinatorView가 호출되고 있는 것을 볼 수 있다.

```swift
WithViewStore(self.store) { viewStore in
	TabView {
  	ACoordinatorView(store: self.store.scope(
    	state: \.a,
      action: TabBarAction.a
    ))
    .tabItem {
    	Image(systemName: "list.dash")
      Text("A")
		}
                
		BCoordinatorView(store: self.store.scope(
    	state: \.b,
      action: TabBarAction.b
    ))
    .tabItem {
    	Image(systemName: "list.dash")
      Text("B")
		}
	}
  .onAppear {
  	print("loginData: ", viewStore.loginData)
	}
}
```



**TabBarInteractor**
는 A, B를 사용해야 하므로 a, b Reducer를 combine한다.

```swift
struct TabBarState: Equatable {
    var loginData: String
    
    var a = ACoordinatorState()
    var b: BCoordinatorState
    
    init(loginData: String) {
        self.loginData = loginData
      	// loginData를 B1에 넘겨주기 위함
        self.b = BCoordinatorState(routes: [.root(.b1(.init(loginData: loginData)))])
    }
}

enum TabBarAction {
    case a(ACoordinatorAction)
    case b(BCoordinatorAction)
}

struct TabBarEnvironmnet { }

let tabBarReducer: Reducer<
    TabBarState,
    TabBarAction,
    TabBarEnvironmnet
> = .combine(
    aCoordinatorReducer
        .pullback(
            state: \.a,
            action: /TabBarAction.a,
            environment: { _ in .init() }
        ),
    bCoordinatorReducer
        .pullback(
            state: \.b,
            action: /TabBarAction.b,
            environment: { _ in .init() }
        )
)
```



### RootCoordinator













