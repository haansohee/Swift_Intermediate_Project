import RxSwift

let disposeBag = DisposeBag()

print("Publish Subject")

let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 안녕")

let sub1 = publishSubject
    .subscribe(onNext: {
        print("첫번째 구독자: ", $0)
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.on(.next("3. 안 들리세요?"))

sub1.dispose()

let sub2 = publishSubject
    .subscribe(onNext: {
        print("두번째 구독자: ", $0)
    })

publishSubject.onNext("4. 여보세요")
publishSubject.onCompleted() // complete됐으니까 5번째는 읽을 수가 없음

publishSubject.onNext("5. 끝났나요?")

sub2.dispose()
//
//2. 들리세요?
//3. 안 들리세요?
//4. 여보세요

publishSubject
    .subscribe {
        print("세번째 구독: ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("6. 찍힐까요?")  // 찍히지 않음. 바라보고 있는 옵저블이 이미 complete됐기 때문

print("\n")
print("Behavior Subject")

enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "초기값g")  // publishSubject는 초기값이 옶었당..
behaviorSubject.onNext("1. 첫번째 값")

behaviorSubject.subscribe {
    print("첫번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)
behaviorSubject.subscribe {
    print("두번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

let value = try? behaviorSubject.value()
print(value)

print("\n")
print("ReplaySubject")
let replaySubject = ReplaySubject<String>.create(bufferSize: 3)

replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만...")

replaySubject.subscribe {
    print("첫번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. 할 수 있어요")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세번째 구독:  ", $0.element ?? $0)
}
.disposed(by: disposeBag)
