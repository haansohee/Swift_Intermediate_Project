import RxSwift

let disposeBag = DisposeBag()

print("Publish Subject")

let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 안녕")

let sub1 = publishSubject
    .subscribe(onNext: {
        print($0)
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.on(.next("3. 안 들리세요?"))

sub1.dispose()

let sub2 = publishSubject
    .subscribe(onNext: {
        print($0)
    })

publishSubject.onNext("4. 여보세요")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝")

sub2.dispose()
