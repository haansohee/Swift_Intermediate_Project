import Foundation
import RxSwift

print("--------just--------")
Observable<Int>.just(1)  // 하나의 element만 방출하는 operator
    .subscribe(onNext: {
        print($0)
    })

print("--------Of--------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("--------Of Array--------")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("--------From--------")
Observable.from([1, 2, 3, 4, 5])  // array의 element들을 하나씩 방출
    .subscribe(onNext: {
        print($0)
    })

print("--------subscribe1--------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("--------subscribe2--------")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("--------subscribe3--------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("--------empty--------")
Observable<Void>.empty()  // 즉시 종료하고픈 Observable, 0개의 값을 가지고 있는 Observable을 return 하고 싶을 때 등 사용
    .subscribe {
        print($0) // completed
    }

print("--------never--------")
Observable<Void>.never()  // 아무것도 방출하지 않는 것ㅋ
    .debug("never")  // 2023-06-29 11:08:24.753: never -> subscribed
    .subscribe(onNext: {
        print($0)
    },
               onCompleted: {
        print("completed")
    }
    )

print("--------range--------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 x \($0) = \($0 * 2 )")
    })

// dispose
print("--------dispose--------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .dispose()

print("--------disposeBag--------")
let disposeBag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)  // 메모리누수 방지

print("--------create1--------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    
    
    return Disposables.create()
}
.subscribe {
    print($0)
}
//.disposed(by: disposeBag)

print("--------create2--------")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    
    return Disposables.create()
}
.subscribe(onNext: {
    print($0)
    },
           onError: {
    print($0.localizedDescription)
    },
           onCompleted: {
    print("completed")
    },
           onDisposed: {
    print("disposed")
    })
//.disposed(by: disposeBag )

print("--------deferred1--------")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("--------deferred2--------")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    if 뒤집기 {
        return Observable.of("☝️")
    } else {
        return Observable.of("👇")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
}

//--------just--------
//1
//--------Of--------
//1
//2
//3
//4 
//5
//--------Of Array--------
//[1, 2, 3, 4, 5]
//--------From--------
//1
//2
//3
//4
//5
//--------subscribe1--------
//next(1)
//next(2)
//next(3)
//completed
//--------subscribe2--------
//1
//2
//3
//--------subscribe3--------
//1
//2
//3
//--------empty--------
//completed
//--------never--------
//2023-06-29 11:49:30.785: never -> subscribed
//--------range--------
//2 x 1 = 2
//2 x 2 = 4
//2 x 3 = 6
//2 x 4 = 8
//2 x 5 = 10
//2 x 6 = 12
//2 x 7 = 14
//2 x 8 = 16
//2 x 9 = 18
//--------dispose--------
//next(1)
//next(2)
//next(3)
//completed
//--------disposeBag--------
//next(1)
//next(2)
//next(3)
//completed
//--------create1--------
//next(1)
//completed
//--------create2--------
//1
//The operation couldn’t be completed. (__lldb_expr_50.MyError error 0.)
//disposed
//--------deferred1--------
//next(1)
//next(2)
//next(3)
//completed
//--------deferred2--------
//☝️
//👇
//☝️
//👇
