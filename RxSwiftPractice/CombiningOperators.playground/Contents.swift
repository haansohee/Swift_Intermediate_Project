import RxSwift

let disposeBag = DisposeBag()

print("🔻🔻🔻🔻🔻🔻🔻startWith🔻🔻🔻🔻🔻🔻🔻")

let 노랑반 = Observable<String>.of("여자아이1", "여자아이2", "남자아이1")

노랑반
    .enumerated()
    .map { index, element in
        return element + "어린이" + "\(index)"
    }
    .startWith("선생님")  // 동일하게 String 타입이 들어가야 함.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("🔻🔻🔻🔻🔻🔻🔻concat1🔻🔻🔻🔻🔻🔻🔻")

let 노랑반어린이들 = Observable<String>.of("여자아이1", "여자아이2", "남자아이1")
let 선생님 = Observable<String>.of("선생님")

let 줄서서걷기 = Observable.concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("🔻🔻🔻🔻🔻🔻🔻concat2🔻🔻🔻🔻🔻🔻🔻")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("🔻🔻🔻🔻🔻🔻🔻concatMap🔻🔻🔻🔻🔻🔻🔻")
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("여자아이1", "여자아이2", "남자아이1"),
    "파랑반": Observable.of("아기1", "아기2")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("🔻🔻🔻🔻🔻🔻🔻merge1🔻🔻🔻🔻🔻🔻🔻")
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
// 순서를 보장하지 않고 섞여서 나옴. 그냥 합친 거.. 따라서 어떤 것이 먼저 나올지 모름! 각각의 요소들이 도착하는 대로 방출함
//강북구
//성북구
//강남구
//동대문구
//강동구
//종로구
//영등포구
//양천구

print("🔻🔻🔻🔻🔻🔻🔻merge2🔻🔻🔻🔻🔻🔻🔻")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1) // maxConcurrent 한번에 받아낼 Observable 수. 그래서 강북 Observable 시퀀스가 완료되기 전까진 강남 안 쳐다봄!
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//강북구
//성북구
//동대문구
//종로구
//강남구
//강동구
//영등포구
//양천구

print("🔻🔻🔻🔻🔻🔻🔻combineLastest1🔻🔻🔻🔻🔻🔻🔻")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("강")
이름.onNext("준식")
이름.onNext("똘똘")
이름.onNext("쭌이")
성.onNext("김")
성.onNext("박")
성.onNext("조")

//강준식
//강똘똘
//강쭌이
//김쭌이
//박쭌이
//조쭌이

print("🔻🔻🔻🔻🔻🔻🔻combineLastest2🔻🔻🔻🔻🔻🔻🔻")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(날짜표시형식,
                   현재날짜,
                   resultSelector: { 형식, 날짜 -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = 형식
        return dateFormatter.string(from: 날짜)
    })

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//7/24/23
//July 24, 2023

print("🔻🔻🔻🔻🔻🔻🔻combineLastest3🔻🔻🔻🔻🔻🔻🔻")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
        
        
    }

fullName
    .subscribe(onNext: {
        print($0)
    })

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")
//Paul Kim
//Stella Kim
//Lily Kim

print("🔻🔻🔻🔻🔻🔻🔻zip🔻🔻🔻🔻🔻🔻🔻")
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승, .패)
let 선수 = Observable<String>.of("한국", "스위스", "미국", "브라질", "일본", "영국")
let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + " \(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//한국선수 승
//스위스선수 승
//미국선수 패
//브라질선수 승
//일본선수 패


print("🔻🔻🔻🔻🔻🔻🔻withLatestFrom1🔻🔻🔻🔻🔻🔻🔻")
let 💥🔫 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

💥🔫
    .withLatestFrom(달리기선수)
    .distinctUntilChanged()  // 이거 쓰면 sample 과 똑같이 사용할 수 있음. (동일한 event 걸러주기)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("선수1")
달리기선수.onNext("선수1, 선수2")
달리기선수.onNext("선수1, 선수2, 선수3")
💥🔫.onNext(Void())
💥🔫.onNext(Void())

//선수1, 선수2, 선수3
//선수1, 선수2, 선수3

print("🔻🔻🔻🔻🔻🔻🔻sample🔻🔻🔻🔻🔻🔻🔻")
let 출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("🏎️")
F1선수.onNext("🏎️     🚗")
F1선수.onNext("🏎️     🚗     🚙")

출발.onNext(Void())
출발.onNext(Void())
출발.onNext(Void())
// 🏎️     🚗     🚙 sample은 withLatestFrom과 비슷하게 작동하지만, 단 한번만 최근의 것만 방출한다는 차이점이 있음.


print("🔻🔻🔻🔻🔻🔻🔻amb🔻🔻🔻🔻🔻🔻🔻") // 두가지 시퀀스를 받을 때 그 두가지 중에 무엇을 구독해야 할지 애매모호할 때
let 버스1 = PublishSubject<String>()
let 버스2 = PublishSubject<String>()
let 버스정류장 = 버스1.amb(버스2)

버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

버스2.onNext("버스2-승객0: 1")
버스1.onNext("버스1-승객0: 2")
버스1.onNext("버스1-승객1: 3")
버스2.onNext("버스2-승객1: 4")
버스1.onNext("버스1-승객1: 5")
버스2.onNext("버스2-승객2: 6")

//버스2-승객0: 1
//버스2-승객1: 4
//버스2-승객2: 6

print("🔻🔻🔻🔻🔻🔻🔻switchLatest🔻🔻🔻🔻🔻🔻🔻")
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()
let 손든사람만말할수있는교실 = 손들기.switchLatest()

손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(학생1)  // 학생1이 아닌 녀석들은 무시
학생1.onNext("학생1: 안녕하세요 저는 1번입니다.")
학생2.onNext("학생2: 저요! 저요저요!")

손들기.onNext(학생2) // 학생2이 아닌 녀석들은 무시
학생2.onNext("학생2: 저는 2번이에요~")
학생1.onNext("학생1: 앗... 나 아직 할 말 있는데")

손들기.onNext(학생3) // 학생3이 아닌 녀석들은 무시
학생2.onNext("학생2: 아니 잠깐만! 내가...")
학생1.onNext("학생1: 언제 말할 수 있는 거죠?")
학생3.onNext("학생3: 저는 3번입니다~ 아무래도 제가 이긴 것 같네요.")

손들기.onNext(학생1) // 학생1이 아닌 녀석들은 무시
학생1.onNext("학생1: 아니? 내가 이겼어")
학생2.onNext("학생2: ㅠㅠ")
학생3.onNext("학생3: 내가 이긴 줄 알았는데")
학생2.onNext("학생2: 이거 이기고 지는 손들기였나요?")

//학생1: 안녕하세요 저는 1번입니다.
//학생2: 저는 2번이에요~
//학생3: 저는 3번입니다~ 아무래도 제가 이긴 것 같네요.
//학생1: 아니? 내가 이겼어

print("🔻🔻🔻🔻🔻🔻🔻reduce🔻🔻🔻🔻🔻🔻🔻")
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//55

print("🔻🔻🔻🔻🔻🔻🔻scan🔻🔻🔻🔻🔻🔻🔻")
Observable.from((1...10))
    .scan(0, accumulator: +)  // 매번 값이 들어올 때마다 방출 reduce
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//1
//3
//6
//10
//15
//21
//28
//36
//45
//55
