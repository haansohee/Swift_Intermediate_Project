import RxSwift

let disposeBag = DisposeBag()

print("-----toArray-----")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0) // ["A", "B", "C"]
    })
    .disposed(by: disposeBag)

print("\n -----map-----")
Observable.of(Date())
    .map {
        date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)  // 2023-07-11
    })
    .disposed(by: disposeBag)

print("\n -----flatMap-----")
protocol seonsu {
    var score: BehaviorSubject<Int> { get }
}

struct 양궁: seonsu {
    var score: BehaviorSubject<Int>
}

let 한국 = 양궁(score: BehaviorSubject<Int>(value: 10))
let 미국 = 양궁(score: BehaviorSubject<Int>(value: 8))

let 올림픽 = PublishSubject<seonsu>()


올림픽
    .flatMap { seonsu in
        seonsu.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽.onNext(한국)  // 한국 선수 출전 ( 한국 선수가 가지고 있던 점수 초기값 방출 )
한국.score.onNext(10)  // 한국 선수 또 10점

올림픽.onNext(미국)  // 미국 선수 출전 ( 미국 선수가 가지고 있던 점수 초기값 방출 )
한국.score.onNext(10)
미국.score.onNext(9)
//
//-----flatMap-----
//10
//10
//8
//10
//9

print("\n -----flatMapLatest-----")  // 가장 최신의 값만 확인하고 싶을 때 사용
struct 높이뛰기선수: seonsu {
    var score: BehaviorSubject<Int>
}

let 서울선수 = 높이뛰기선수(score: BehaviorSubject<Int>(value: 7))
let 제주선수 = 높이뛰기선수(score: BehaviorSubject<Int>(value: 6))

let 전국체전 = PublishSubject<seonsu>()

전국체전
    .flatMapLatest { seonsu in
        seonsu.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울선수)
서울선수.score.onNext(9)

전국체전.onNext(제주선수)
서울선수.score.onNext(10)
제주선수.score.onNext(8)


print("\n -----materialize and ddmaterialize-----")
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: seonsu {
    var score: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(score: BehaviorSubject<Int>(value: 0))
let 박치타 = 달리기선수(score: BehaviorSubject<Int>(value: 1))

let 달리기100M = BehaviorSubject<seonsu>(value: 김토끼)  // 첫번째 선수를 김토끼로 초기 설정

달리기100M
    .flatMapLatest { seonsu in
        seonsu.score
            .materialize()
    }
    .filter {
        guard let error = $0.error else {  // error가 없을 때만 통과~!
            return true
        }
        print(error)
        return false
    }
    .dematerialize()  // filter 벗어나지 않도록..
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

김토끼.score.onNext(1)  // 토끼 점수 획득
김토끼.score.onError(반칙.부정출발)
김토끼.score.onNext(2)  // 토끼 점수 획득 2

달리기100M.onNext(박치타)  // 치타 선수 출전!

//0
//1
//Unhandled error happened: 부정출발  (반칙 생기고서 어떠한 방출이 나오지 않음)
// but..!! materialize 사용하면..!
//next(0)
//next(1)
//error(부정출발)
//next(1)

//dematerialize 사용하면..!
//0  // 토끼 선수의 초기값
//1  // 토끼 선수의 점수 획득
//부정출발  // 에러
//1  // 박치타 선수의 초기값 (박치타라는 새로운 시퀀스가 나왔기 때문에 ..)


print("\n -----전화번호 11자리 예제-----")
let input = PublishSubject<Int?>()
let list: [Int] = [1]

input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0})
    .take(11)  // 010-1234-1234 총 11자리니까
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" }
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(1)
// 총 14개의 이벤트를 보냄
// 결과 :  010-4318-9491

