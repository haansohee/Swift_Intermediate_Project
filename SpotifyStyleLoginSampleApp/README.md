# Release Notes
- 불가피하게 발생하는 업데이트에 따른 코드의 변경을 기록하는 곳입니다.

## Version 2 (2021.10.22)
### 외부 라이브러리에 대한 버전 지정
- 추후 발생할 수 있는 업데이트에 따른 혼란을 최소화하기 위해 강의 시점의 버전으로 지정함
- 기존 Podfile내에 다음과 같이 업데이트 됨
    ```
    pod 'Firebase/Auth', '8.6.0'
    pod 'Firebase/Firestore', '8.6.0'
    pod 'GoogleSignIn', '5.0.2'
    ```

## Version 1 (2021.9.30)
### `GoogleSignIn` 버전 업데이트
- Google로 로그인에 필요한 외부 라이브러리(`GoogleSignIn`)가 업데이트 됨에 따라 Pod의 버전을 지정함
- 기존 Podfile내에 다음과 같이 업데이트 됨 
    ```
    pod 'GoogleSignIn', '~> 5.0.2'
    ```

## Version 0 (2021.9.3)
- 강의 최초 공개
