import RxSwift
import RxCocoa
import UIKit
import PlaygroundSupport

let disposeBag = DisposeBag()

print("🔽🔽🔽🔽🔽🔽replay🔽🔽🔽🔽🔽🔽")
let 인사말 = PublishSubject<String>()
let 반복하는앵무새 = 인사말.replay(1)  // buffer의 개수만큼 최신 순서대로 받을 수 있음.

반복하는앵무새.connect()  // replay 관련 연산자를 사용할 때는 반드시 connect 해 주어야 함.

인사말.onNext("1. Hello")
인사말.onNext("2. Hi")

반복하는앵무새
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//2. Hi (지나간 이벤트 중 최신의 하나는 받을 수 있도록 했기 때문) : let 반복하는앵무새 = 인사말.replay(1)
// let 반복하는앵무새 = 인사말.replay(2)로 하면
//1. Hello
//2. Hi

인사말.onNext("3. 안녕하세요")
//2. Hi
//3. 안녕하세요 : 버퍼 사이즈와 상관없이 구독 이후에 발생한 이벤트는 무조건 나타내게 됨.

print("\n")
print("🔽🔽🔽🔽🔽🔽replayAll🔽🔽🔽🔽🔽🔽")
let 닥터스트레인지  = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()
타임스톤.connect()

닥터스트레인지.onNext("도르마무,")
닥터스트레인지.onNext("거래를 하러 왔다.")

타임스톤
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//도르마무,
//거래를 하러 왔다. : 지나간 이벤트 방출에 대해서 그 이후에 구독을 하더라도 그 전의 값들을 볼 수 있도록 하는 replayAll

//print("\n")
//print("🔽🔽🔽🔽🔽🔽buffer🔽🔽🔽🔽🔽🔽")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))  // 현재시점부터 2초를 데드라인, 매번 1초마다 반복되게
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//            count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//print("\n")
//print("🔽🔽🔽🔽🔽🔽window🔽🔽🔽🔽🔽🔽")
//// buffer와 비슷하지만 다른 점은 buffer가 array를 방출하는 반면, window는 observable을 방출함.
//
//let 만들어낼최대Observable수 = 5
//let 만들시간 = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSource.resume()
//
//window
//    .window(
//        timeSpan: 만들시간,
//        count: 만들어낼최대Observable수,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index) 번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)
//
////0 번째 Observable의 요소 1
////0 번째 Observable의 요소 2
////0 번째 Observable의 요소 3
////0 번째 Observable의 요소 4
////0 번째 Observable의 요소 5
////0 번째 Observable의 요소 6
////0 번째 Observable의 요소 7

//print("\n")
//print("🔽🔽🔽🔽🔽🔽delaySubscription🔽🔽🔽🔽🔽🔽")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(2), scheduler: MainScheduler.instance)  // 2초 정도 딜레이
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//print("\n")
//print("🔽🔽🔽🔽🔽🔽delay🔽🔽🔽🔽🔽🔽")
//// delaySubscription이 구독을 지연했다면, delay는 전체 시퀀스를 뒤로 미루는.. 구독은 하지만 설정한 기간만큼 요소의 방출을 미루는 것.
//let delaySubject = PublishSubject<Int>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext(delayCount)
//}
//delayTimerSource.resume()
//
//delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//print("\n")
//print("🔽🔽🔽🔽🔽🔽interval🔽🔽🔽🔽🔽🔽")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("\n")
print("🔽🔽🔽🔽🔽🔽timer🔽🔽🔽🔽🔽🔽")  // 마감일 설정 가능.. 반복할 수 있는 기간이 옵셔널. 만약 반복 설정하지 않으면 timer는 한번만 방출하고 끝
Observable<Int>
    .timer(
        .seconds(5),
        period: .seconds(2),
        scheduler: MainScheduler.instance
    )
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("\n")
print("🔽🔽🔽🔽🔽🔽timeout🔽🔽🔽🔽🔽🔽")
let 누르지않으면에러 = UIButton(type: .system)
누르지않으면에러.setTitle("눌러주세요", for: .normal)
누르지않으면에러.sizeToFit()

PlaygroundPage.current.liveView = 누르지않으면에러

누르지않으면에러.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
