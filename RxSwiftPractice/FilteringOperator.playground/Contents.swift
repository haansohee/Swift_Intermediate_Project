import RxSwift

let disposeBag = DisposeBag()

print("-----ignoreElements-----")
let sleepMode = PublishSubject<String>()  //

sleepMode
    .ignoreElements()  // onNext이벤트만 무시하는 필터링
    .subscribe{
//        print("☀️")
        print($0)
    }
    .disposed(by: disposeBag)

sleepMode.onNext("⏰")
sleepMode.onNext("⏰")
sleepMode.onNext("⏰")

sleepMode.onCompleted()


print("-----elementAt-----")

let secondMan = PublishSubject<String>()

secondMan
    .element(at: 2)  // 특정 index 값만 방출하겠다는 필터링
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

secondMan.onNext("⏰")  // Index 0
secondMan.onNext("⏰")  // index 1
secondMan.onNext("🙋")  // index 2
secondMan.onNext("⏰")  // index 3


print("-----filter-----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)  // [1, 2, 3, 4, 5, 6, 7, 8]
    .filter { $0 % 2 == 0 } // 짝수만 방출하고 싶어~}
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----skip-----")
Observable.of(2, 4, 6, 8, 9)
    .skip(4)  // 처음부터 몇 개의 요소를 스킵할 것인지
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----skipWhile-----")

Observable.of(2, 4, 6, 8, 10, 13, 14, 16)
    .skip(while: {
        $0 % 2 == 0
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----skipUntil-----")

let guest = PublishSubject<String>()
let openTime = PublishSubject<String>()

guest  // 현재 observable
    .skip(until: openTime)  // 다른 observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

guest.onNext("🙆‍♂️")
guest.onNext("🙆‍♂️2")

openTime.onNext("땡")
guest.onNext("🙆‍♂️3")


print("-----take-----")

Observable.of("🏅", "🥈", "🥉", "사람1", "사람2")
    .take(3)  // skip의 반대개념. 처음부터 3개까지만 방출하기
    .subscribe(onNext:  {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----takeWhile-----")
Observable.of("🏅", "🥈", "🥉", "사람1", "사람2")
    .take(while: {  // skipWhile의 반대 개념.
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----enumerated-----")
Observable.of("🏅", "🥈", "🥉", "사람1", "사람2")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----takeUntil-----")
let signUp = PublishSubject<String>()
let deadline = PublishSubject<String>()

signUp
    .take(until: deadline)  // skipUntil과 반대.!!
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

signUp.onNext("🙋")
signUp.onNext("🙋2")

deadline.onNext("신청 마감!~")
signUp.onNext("🙋3")


print("-----distinctUntilChanged-----")
Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "입니다", "입니다", "입니다", "입니다", "저는", "앵무새", "일까요?", "일까요?")
    .distinctUntilChanged()  // 연달아 같은 값이 이어질 때 중복된 값을 막아주는 연산자
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//저는
//앵무새
//입니다
//저는
//앵무새
//일까요?
