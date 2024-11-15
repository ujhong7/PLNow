# FootballApp

### 프로젝트 개요

- 인원: 1명
- 기간: 2024.10.04 ~ 2024.11.06

### 한 줄 소개

- RapidAPI를 활용해 프리미어리그 팀순위, 경기결과, 선수 순위 및 경기 스쿼드 정보를 확인할 수 있는 앱

### 앱 미리보기

<table align="center" width="100%"> 
  <tr>
    <td align="center"><img src="https://imgur.com/XZFWXrl.gif" width="175"><br>팀 정보</td>
    <td align="center"><img src="https://imgur.com/Qd1J8bW.gif" width="175"><br>경기결과</td>
    <td align="center"><img src="https://imgur.com/9jz4dof.gif" width="175"><br>경기예정</td>
    <td align="center"><img src="https://imgur.com/RzZX0F2.gif" width="175"><br>득점 선수정보</td>
    <td align="center"><img src="https://imgur.com/asNY8QN.gif" width="175"><br>도움 선수정보</td>
  </tr>
</table>


### 개발 환경

- Deployment Target: 16.4
- Localizations: English
- App Appearances: Light

### 기술

- **Architecture** : `MVC`
- **UI** : `UIKit`
- **Network** : `URLSession`, `REST API` (via `RapidAPI`), `Result-based API 호출`
  - `NetworkProvider`를 통해 공통 네트워크 요청 관리
  - `FootballNetworkService`를 사용해 프리미어리그 경기 일정 및 결과 데이터 가져오기
- **Image Caching** : `NSCache`, `Disk Caching`
  - 메모리 및 디스크 캐시를 사용해 이미지를 효율적으로 관리하고, 불필요한 네트워크 요청을 최소화하여 앱 성능을 최적화
  - URL의 SHA-256 해시를 활용한 파일 이름으로 이미지의 중복 다운로드를 방지
- **Screen Navigation** : `Segmented Control`, `UIPageViewController`
  - `Segmented Control`을 사용하여 팀 순위, 경기 결과, 득점 순위 등 다양한 정보를 한 화면에서 손쉽게 전환할 수 있도록 구성
  - `UIPageViewController`와 결합하여 각 세그먼트를 선택할 때 애니메이션을 통한 부드러운 화면 전환을 제공하며, 사용자 경험을 향상
  - `UIPageViewControllerDelegate와` `UIPageViewControllerDataSource`를 활용해 현재 선택된 세그먼트와 화면을 동기화하여,    
     일관된 네비게이션 경험을 제공
- **StackView** 활용을 통한 통계 UI 구성
  - 프로젝트 내 다양한 화면 구성에서 `UIStackView`를 적극적으로 활용하여 통계를 간결하게 표현   
    스택뷰를 사용함으로써 코드 간소화와 함께 레이아웃의 일관성을 유지하고, 개별 구성 요소의 유연성을 높임
    
  
### 기능

<table align="center" width="100%" border="1">
  <tr>
    <th align="center">팀 순위표</th>
    <th align="center">라운드 별 지난 경기결과</th>
    <th align="center">라운드 별 경기예정</th>
    <th align="center">득점 순위표</th>
    <th align="center">도움 순위표</th>
  </tr>
  <tr>
    <td>
      - 스쿼드<br>
      - 경기예정<br>
      - 경기기록
    </td>
    <td>
      - 경기 정보<br>
      - 경기 기록<br>
      - 선수명단<br>
      - 경기 통계
    </td>
    <td>
      - 경기 정보<br>
      - 상대전적
    </td>
    <td>
      - 선수 프로필<br>
      - 지난 5개 시즌 통계<br>
      - 이력 (이적정보)
    </td>
    <td>
      - 선수 프로필<br>
      - 지난 5개 시즌 통계<br>
      - 이력 (이적정보)
    </td>
  </tr>
</table>

### 폴더 구조
  ```
  ├── 📁Network
  │   ├── NetworkProvider.swift
  │   └── FootballNetworkService.swift
  ├── 📁Model
  │   ├── FixtureModel.swift
  │   ├── PlayerRankingResponse.swift
  │   └── …
  ├── 📁Scenes
  │   ├── 📁GameViewController
  │   │   ├── 📁TeamRanking
  │   │   │   ├── TeamRankingViewController.swift
  │   │   │   ├── TeamRankingInformationViewController.swift
  │   │   │   ├── 📁cell
  │   │   │   │   ├── TeamRankingTableViewCell.swift
  │   │   │   │   ├── TeamSquadTableViewCell.swift
  │   │   │   │   └── TeamCoachTableViewCell.swift
  │   │   │   └── 📁Segment
  │   │   │       ├── TeamSquadViewController.swift
  │   │   │       ├── TeamNextMatchViewController.swift
  │   │   │       └── TeamPreviousMatchViewController.swift
  │   │   ├── 📁Match
  │   │   │   ├── 📁Result
  │   │   │   │   ├── MatchResultViewController.swift
  │   │   │   │   ├── MatchResultInformationViewController.swift
  │   │   │   ├── 📁UpComing
  │   │   │   │   ├── UpcomingMatchViewController.swift
  │   │   │   │   ├── UpcomingMatchInformationViewController.swift
  │   │   │   ├── 📁cell
  │   │   │   │   ├── …
  │   │   │   ├── 📁Segment
  │   │   │   │   ├── …
  │   │   ├── 📁Players
  │   │   │   ├── GoalsPlayerViewController.swift
  │   │   │   ├── AssistsPlayerViewController.swift
  │   │   │   ├── PlayerInformationViewController.swift
  │   │   │   ├── 📁cell
  │   │   │   │   └── …
  │   │   │   └── 📁Segment
  │   │   │       └── …
  ```

### 주요 성과
  
- **일관된 모듈화로 코드 재사용성과 확장 가능성 강화**
    - 예를 들어 `TeamRankingViewController`와 `TeamRankingInformationViewController` 같이  
      반복적인 구조 설계를 통해 주요 화면이 동일한 패턴으로 관리되도록 하여 코드 재사용성을 높이고,  
      새로운 정보 유형 추가나 기존 컨트롤러 확장이 더 쉬워짐.  
      또한 이 구조는 각 메인 뷰와 정보 뷰 컨트롤러가 공통 템플릿을 통해 확장될 수 있도록 기반을 마련하여 유지보수와 확장성이 크게 강화됨.
       <br><br>
- **동적 데이터 처리 및 효율적 UI 구성**
    - 다양한 팀 및 선수 정보를 동적으로 받아와 실시간으로 UI에 반영하였으며,  
      `MatchSummaryTableViewCell`, `SquadTableViewCell`, `StatisticsTableViewCell`에서 데이터를 모델로부터 받아 UI를 동적으로 업데이트하도록 구현함.  
      AutoLayout과 UIStackView를 활용해 화면 크기에 따라 자동으로 조정되는 유연한 레이아웃을 구성하고, UITableViewCell을 재사용하여 성능 최적화를 달성함.
       <br><br>
- **유연하고 유지보수성 높은 뷰 설계**
    - 커스텀 셀 클래스인 `StatisticsTableViewCell`에서는 공통 구조를 적용하여  
      데이터 타입이 달라져도 같은 레이아웃을 재사용할 수 있도록 하여 유지보수성을 높임.  
      또한 모델과 UI 요소를 명확히 분리해 데이터 구조가 변경될 때에도 UI 업데이트가 용이하도록 구성함.
       <br><br>
- **사용자 친화적 UI와 정보 구획화**
    - 세그먼트를 통해 각 주요 정보 섹션을 구획화하여 사용자가 직관적으로 탐색할 수 있도록 설계함.  
      `StatisticsTableViewCell`에서는 홈팀과 어웨이팀의 통계 비교를 막대 그래프와 함께 시각적으로 표현하여 정보 접근성과 탐색성을 높였으며,  
      UIStackView를 사용해 UI가 동적으로 조정되도록 구성하여 복잡성을 줄임.
       <br><br>
- **동적 이벤트 처리와 UI 업데이트 최적화**
    - `MatchSummaryTableViewCell`에서 경기 이벤트를 실시간으로 반영하여 UI에 동적으로 업데이트되는 기능을 구현함.  
      `configureEvents(with:)` 메서드를 통해 경기 이벤트(예: 골, 카드, 교체 등)를 시간 순으로 정렬하고,  
      이벤트별로 알맞은 UI 요소(예: ⚽️, 🟨 카드 등)로 표시하여 사용자가 정보를 직관적으로 확인할 수 있도록 지원함.  
      또한, 이벤트가 없을 경우 '경기가 아직 진행되지 않았습니다.'라는 메시지를 표시하여 사용자 경험을 개선함.
       <br><br>
- **유연한 레이아웃 설계로 다양한 기기에서의 호환성 확보**
    - `MatchSummaryTableViewCell`에서 `UIStackView`와 AutoLayout을 사용하여  
      다양한 화면 크기와 해상도에서 유연하게 UI가 조정될 수 있도록 설계함.  
      이로 인해, 다양한 화면 크기와 해상도에서 일관된 레이아웃을 제공하며, 추후 추가적인 뷰 변경 시에도 간단한 수정으로 적응 가능함.
       <br><br>

---

## 트러블 슈팅 

### 1️⃣ 델리게이트를 활용해 뷰 내 UITableView 스크롤 시 상위 뷰와 동기화하여 전체 화면 스크롤 가능하게 만들기

<div style="display: flex; justify-content: space-between;">
  <img src="https://imgur.com/OH4ShQe.gif" width="200">
  <img src="https://imgur.com/bZTa8yJ.gif" width="200">
</div>


#### 🤔 **상황**  

`TeamRankingInformationViewController`는   
`InformationView`와 세그먼트 기반의 페이지 뷰 중 하나인 `TeamSquadViewController`로 구성되어 있습니다.   
`TeamSquadViewController`는 팀의 선수 명단을 나타내는 `UITableView`를 사용하고 있습니다.   
이때, `UITableView`는 `InformationView`와 함께 화면에 표시되어   
사용자가 테이블을 스크롤할 때 `InformationView`가 고정되어 있는 문제를 겪게 되었습니다.  

### 🚨 **문제**

`TeamSquadViewController`의 `UITableView`가 `InformationView`와 세그먼트의 페이지 뷰 위에 함께 표시되므로,   
`UITableView`를 스크롤할 때 `InformationView`가 화면 상단에 고정되어 있어 화면을 차지하게 됩니다.   
이로 인해 `UITableView`가 전체 화면을 활용하지 못하고, 스크롤이 제한되어 사용자는 불편함을 겪었습니다.   
`UITableView`가 충분히 확장되지 않으며 화면을 자유롭게 스크롤할 수 없었습니다.  

#### 🛠️ **해결 과정**

해결을 위해 `UIScrollViewDelegate`를 활용하여,   
`TeamSquadViewController`의 `UITableView`가 화면을 전체적으로 스크롤할 수 있도록 구현하였습니다.    
`TeamRankingInformationViewController`와 `TeamSquadViewController`가 함께 스크롤되는 구조를 만들기 위해, 아래와 같은 방법을 적용했습니다:    

1. **`ScrollDelegate` 프로토콜을 통해 스크롤 이벤트 처리**:   
`TeamSquadViewController`에서 `scrollDelegate`를 사용하여 `scrollViewDidScroll` 메서드로 스크롤 이벤트를 처리하도록 했습니다.     
이를 통해 `TeamSquadViewController` 내의 `UITableView`가 스크롤될 때,    
상위 뷰인 `TeamRankingInformationViewController`에서 이를 감지하고 스크롤을 조정하도록 했습니다.    

    <img width="322" alt="image" src="https://github.com/user-attachments/assets/7316d38b-a93c-41da-9a36-998ed5c774cf">


2. 스크롤 델리게이트 호출:   
`TeamSquadViewController`에서 `UIScrollViewDelegate`를 구현하고,    
`scrollViewDidScroll` 메서드에서 `scrollDelegate?.didScroll`을 호출하여 상위 뷰로 스크롤 오프셋을 전달하고 이를 처리할 수 있도록 했습니다.   

    <img width="617" alt="image" src="https://github.com/user-attachments/assets/530aafcf-e836-4c12-9f4a-165289f2ea48">


3. 상위 뷰에서 스크롤 동작을 반영: 
`TeamRankingInformationViewController`에서는 `scrollDelegate?.didScroll` 메서드를 통해 받은 yOffset 값을 처리하고,
화면 전환 시 불필요한 고정 위치를 제거하여 스크롤 영역을 늘리는 방식으로 화면 전체 스크롤을 가능하게 했습니다.     

    <img width="820" alt="image" src="https://github.com/user-attachments/assets/766e5abb-efae-4019-ae29-eaae8c08dbe9">


#### 📝 **결과**

이 해결책을 통해, 사용자는 이제    
`TeamSquadViewController` 내의 `UITableView`를 기기의 전체 화면을 활용하여 자유롭게 스크롤할 수 있게 되었습니다.     
`InformationView`가 화면 상단에 고정되어 있었던 문제를 해결하면서,   
`UITableView`가 전체 화면을 차지하게 되어 스크롤이 자연스럽게 이루어졌습니다.    
또한, `UIScrollViewDelegate`를 활용하여 스크롤 이벤트를 처리하고,   
상위 뷰와의 협업을 통해 부드럽고 일관된 스크롤 환경을 제공할 수 있었습니다.   


<br>

### 2️⃣ 데이터 모델 타입 불일치 해결

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/5dceb168-ba71-4ad3-8f81-8101bf58b770" width="400">
  <img src="https://github.com/user-attachments/assets/f096bd1a-3ae1-4db5-b06a-d03f16170cb2" width="200">
</div>

#### 🤔 **상황**

경기 통계 데이터를 API에서 받아오는 과정에서, statistics 항목의 value 필드가 다양한 타입을 가진다는 사실을 간과했습니다.    
value는 일부 항목에서 Int 타입이, 다른 항목에서는 String 타입이 제공되는 경우가 있었습니다.     
이로 인해 API에서 데이터를 디코딩하는 과정에서 오류가 발생하고 있었습니다.    

#### 🚨 **문제**

처음에는 value 필드가 모두 Int 타입일 것이라 가정하고 데이터를 처리하려 했으나,     
실제로는 Int와 String 두 가지 타입을 모두 처리해야 했습니다.     
이를 해결하기 위해 value 필드를 Int?로 선언했지만, value 필드가 String 값을 가질 경우 디코딩이 실패하여 앱에서 예외가 발생했습니다.    

#### 🛠️ **해결 과정**

유연한 타입 처리:    
value 필드의 타입이 Int와 String 두 가지일 수 있다는 점을 반영하여 ValueType이라는 enum을 도입했습니다.     
이를 통해 두 가지 타입을 모두 처리할 수 있도록 했습니다.     

<img width="450" alt="image" src="https://github.com/user-attachments/assets/6ceb20f3-449a-44a4-a88c-dba21b5b047e">


디코딩 및 null 처리:
ValueType을 사용해 value가 Int일 경우와 String일 경우를 자동으로 처리할 수 있게 했습니다.    
또한 value가 null일 경우를 처리하기 위해 ValueType.none을 도입하여 안정적인 디코딩을 보장했습니다.    

#### 📝 **결과**

value 필드가 Int와 String 두 가지 타입을 가질 수 있음을 인지하고,    
이를 처리할 수 있는 데이터 모델을 설계함으로써 API에서 받은 데이터를 정확히 디코딩할 수 있었습니다.     
value 필드가 null이거나 두 가지 타입 중 하나일 때도 안전하게 처리할 수 있었고, 예외 없이 데이터를 올바르게 표시할 수 있게 되었습니다.  

<br>

### 3️⃣ 세그먼트 컨트롤을 활용한 메뉴 탭 개선

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/9de3b192-277e-4e91-8994-1c8b65e9cddb" width="200">
  <img src="https://github.com/user-attachments/assets/b867e073-47bd-4c9d-acc1-4f5c81b1acc0" width="175">
</div>

#### 🤔 **상황**

<img width="500" alt="image" src="https://github.com/user-attachments/assets/012bab34-2457-4f1a-adfc-cc52167063e5">

기존에는 컬렉션뷰를 통해 메뉴 탭을 구현하고, 탭 선택에 따라 테이블뷰가 리로드되도록 했습니다.      
하지만 이 방식은 화면이 빈번하게 갱신되어 사용자 경험에 불편을 초래했습니다.   

#### 🚨 **문제**

<img width="600" alt="image" src="https://github.com/user-attachments/assets/98fd2a55-07a7-4ded-86e1-65625060cff3">
<br>
<img width="300" alt="image" src="https://github.com/user-attachments/assets/90ed8b06-0454-48db-ae87-2dee32232ccd">
<br>
<img width="350" alt="image" src="https://github.com/user-attachments/assets/2fc55d64-af7c-4315-9ad5-ea47ce52de10">

컬렉션뷰 항목 선택 시 기존 테이블뷰를 리로드하여 새로운 데이터로 교체하다 보니   
화면 전환이 부자연스럽고 UX가 저하되는 문제가 있었습니다.   
반복적인 리로드로 인해 성능 효율성에도 문제가 발생했습니다.   

#### 🛠️ **해결 과정**

- 세그먼트 컨트롤로 메뉴 탭 개선     
  <img width="500" alt="image" src="https://github.com/user-attachments/assets/6d4791b9-bc45-4695-81ed-562c470adcaa">
  <img width="500" alt="image" src="https://github.com/user-attachments/assets/477fa4a8-0832-4cb0-b7e8-27ec8e8a667d">
  - 컬렉션뷰 대신  세그먼트 컨트롤을 메뉴 탭으로 적용하여 각 세그먼트가 고유한 테이블뷰를 소유하도록 했습니다.  
  - 이를 통해 선택된 세그먼트에 맞는 테이블뷰만 표시되도록 구조를 변경했습니다.  
- 독립적인 테이블뷰 관리     
  <img width="330" alt="image" src="https://github.com/user-attachments/assets/0f7a9f5f-3a8a-4772-b761-9b5cc5250a5c">
  - 세그먼트마다 별도의 테이블뷰를 두어 각 테이블뷰가 고유 데이터를 유지하도록 구성했습니다.   
  - 이로써 탭 전환 시마다 매번 테이블뷰 데이터를 바꿔치기할 필요 없이 독립적인 테이블뷰가 순환될 수 있었습니다.   
- 자연스러운 전환 및 성능 개선    
  <img width="750" alt="image" src="https://github.com/user-attachments/assets/9fed07a0-6421-4827-890c-f07ef78aca61">     
  - 세그먼트 전환 시 불필요한 테이블뷰 리로드를 방지함으로써 성능이 최적화되었고, 사용자에게 자연스러운 화면 전환을 제공할 수 있었습니다.  

#### 📝 **결과**

세그먼트 컨트롤을 통해 사용자 경험이 개선되어, 화면 전환이 매끄럽고 일관되게 느껴졌습니다.      
테이블뷰 데이터를 독립적으로 유지하여 데이터 일관성이 향상되고, 성능 효율이 개선되었습니다.    

<br>

### 2️⃣ ㅇㅇ


#### 🤔 **상황**  



### 🚨 **문제**



### 🛠️ **해결 과정**



### 📝 **결과**






---

## 화면 스크린샷

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/a9e3615f-5448-49c4-bb29-c97fc6e00355" width="150">
  <img src="https://github.com/user-attachments/assets/396a3f1d-e9be-409e-8f17-f6ceac58191d" width="150">
  <img src="https://github.com/user-attachments/assets/1e7e31e6-257c-48a5-8705-3663fb750219" width="150">
  <img src="https://github.com/user-attachments/assets/c625d6f6-47f2-44d8-b558-7dc64b93634b" width="150">
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/655e37f5-171b-4751-9319-8924dab326e6" width="150">
  <img src="https://github.com/user-attachments/assets/9aac1d2c-14e3-469b-be37-a71f938f297c" width="150">
  <img src="https://github.com/user-attachments/assets/3bcbed39-8c3a-45b5-b1ae-bddf982e25f7" width="150">
  <img src="https://github.com/user-attachments/assets/7790e783-d023-44ff-bb16-4dab07b16109" width="150">
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/5c2f7765-7d5a-4c19-a117-90135b40b3dd" width="150">
  <img src="https://github.com/user-attachments/assets/ec7c6428-fbab-42c2-b7e1-11160c22c42c" width="150">
  <img src="https://github.com/user-attachments/assets/2411a680-0121-420e-94a1-5c11202fea23" width="150">
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/a18222c5-f661-45d4-98be-f0ca41bc9926" width="150">
  <img src="https://github.com/user-attachments/assets/bada5ef9-8c25-4439-b3ff-14efaf8e5201" width="150">
  <img src="https://github.com/user-attachments/assets/196d56bd-b2ba-4e8e-9d10-c8464b144420" width="150">
  <img src="https://github.com/user-attachments/assets/a485749f-ad0a-4392-93fb-87686fe51d3a" width="150">
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/161f0a8f-5f03-41c0-b7b7-2be1b42d5af8" width="150">
  <img src="https://github.com/user-attachments/assets/b2ba3d29-5a1e-4aff-a2dd-f4ba76b69a10" width="150">
  <img src="https://github.com/user-attachments/assets/60838813-708d-451a-9d47-48a33654fe26" width="150">
  <img src="https://github.com/user-attachments/assets/bdea22c8-84a7-4435-9db7-36f3c03122a0" width="150">
</div>



















