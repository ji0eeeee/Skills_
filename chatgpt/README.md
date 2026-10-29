# ChatGPT(Codex) 스킬 안내

ChatGPT의 코딩 에이전트 **Codex**(앱·CLI·IDE 확장)에서 쓰는 연구용 스킬 41개입니다.
스킬은 AI가 반복 작업을 같은 방식으로 하도록 적어 둔 지침 파일(`skills/<이름>/SKILL.md`)입니다. 설치하면 Codex가 요청에 맞는 스킬을 골라 쓰고, `$스킬명`으로 직접 부를 수도 있습니다.

범용 지침을 연구에 맞게 소개한 것이며, 분야별 방법·통계·실험 타당성을 자동으로 보장하지 않습니다.

## 설치

Git과 Python 3.9 이상이 필요합니다.

```bash
git clone https://github.com/ji0eeeee/Skills_.git
cd Skills_/chatgpt
python scripts/install.py --list
python scripts/install.py --dry-run
python scripts/install.py
```

- 설치 위치는 `~/.agents/skills`입니다. 이미 같은 이름의 스킬이 있으면 건너뜁니다.
- 일부만 설치: `python scripts/install.py --skills grill-me research handoff`
- 한 프로젝트에서만 사용: `python scripts/install.py --dest <프로젝트>/.agents/skills`
- Windows는 `python` 대신 `py -3`, macOS·Linux는 `python3`를 써도 됩니다.
- 설치 후 Codex를 다시 시작하면 스킬 목록에 나타납니다.

Codex에 맡기려면 이렇게 요청합니다.

```text
https://github.com/ji0eeeee/Skills_ 의 chatgpt/README.md를 읽고
chatgpt/catalog.json의 스킬을 ~/.agents/skills에 설치해줘.
이미 있는 스킬은 건너뛰고 보조 파일도 포함해줘.
```

## 호출 방법

| 방법 | 예 |
|---|---|
| 이름으로 부르기 | `$grill-me 이 연구계획을 검토해줘` |
| 이름 없이 요청 | 설명이 맞는 스킬을 Codex가 자동으로 고릅니다 |

아래 표의 **대표 요청**을 그대로 복사해 연구 대상과 자료만 바꿔 쓰면 됩니다.

## 연구 단계별로 선택하기

| 지금 하려는 연구 업무 | 먼저 사용할 기능 | 기대할 결과 |
|---|---|---|
| 연구 질문·가설·설계를 검토 | Grill Me · Grill with Docs | 미정 사항, 가정과 합의된 연구 설계 |
| 선행연구와 방법의 근거를 확인 | Research · GPT Researcher · PDF | 출처별 주장, 검증 상태와 연구 공백 |
| 분석 코드를 이해하고 재현 | Serena · Karpathy Guidelines · Notebooks | 계산 경로, 가정과 재실행 가능한 분석 |
| 결과를 논문 주장으로 연결 | Writing Fragments → Writing Shape/Beats | 근거가 있는 주장과 논증 순서 |
| 원고의 투고 적합성·모델별 비판·수정 효과를 검토 | Review Paper · AI Peer Review · paper-reviewer | 저널별 사전 심사, 모델별 지적 비교와 수정 이력 |
| 결과·절차를 보여주거나 발표 | Visualize Data · Archify · Presentations | 정량 그림, 절차 도식과 발표 자료 |
| 공동연구자와 결정·작업을 공유 | Handoff · To Questionnaire · Notion/Drive | 인수인계, 확인 질문과 결정 기록 |
| 새로운 연구 환경을 준비 | 설치 안내 · Skill Creator · Context7 | 재사용 가능한 지침과 연결된 도구 |

Research와 GPT Researcher의 결과는 **문헌 조사 초안과 근거 후보**입니다.
체계적 문헌고찰의 검색 완전성, 논문 품질 평가, DOI 일치와 원문 내용의 검증을 자동으로 보장하지 않습니다.
논문 원문·표준·공식 문서의 주장과 연구자의 해석, 수행한 분석과 계획 단계를 구분해 요청하세요.


## 연구 업무별 스킬

이 폴더의 41개 스킬을 연구 업무별로 소개합니다. Archify, Visualize Data, Presentations처럼 굵게 표시한 항목은 이 폴더에 없고 따로 설치하는 도구입니다.
한국어 업무명과 실제 호출 이름을 함께 표시합니다.
`$스킬명`은 실제 호출 이름이며, 요청 내용의 연구 대상과 자료를 본인 프로젝트에 맞게 바꾸세요.

### 연구 질문·가설·연구 설계

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [연구 단계별 도구 선택](skills/ask-matt/SKILL.md) | `$ask-matt` | 현재 연구의 진행 단계와 필요한 산출물을 확인하고, 어떤 스킬을 어떤 순서로 사용할지 제안해줘. | 연구 단계별 실행 순서 |
| [연구 질문·설계 검토](skills/grill-me/SKILL.md) | `$grill-me` | 이 연구계획의 연구 질문, 가설, 독립·종속변수, 비교 조건, 교란요인과 검증 방법을 검토해줘. 수행된 연구와 계획 단계는 구분하고, 질문은 한 번에 하나씩 해줘. | 검토 질문과 합의된 설계 |
| [연구 설계·결정 기록](skills/grill-with-docs/SKILL.md) | `$grill-with-docs` | 이 연구계획을 검토하면서 합의한 용어와 방법 선택의 이유를 CONTEXT.md와 설계 결정 문서에 기록해줘. | 연구 용어집·결정 기록 |
| [연구 의사결정 검토](skills/grilling/SKILL.md) | `$grilling` | 이 연구 방법의 대안과 선택 기준을 확인하고, 결론에 영향을 주는 미정 사항부터 질문해줘. | 결정 기준과 미정 사항 |
| [반복 연구 절차 명세](skills/loop-me/SKILL.md) | `$loop-me` | 우리 연구실의 문헌 수집, 데이터 전처리, 분석, 보고 과정을 확인하고 반복 가능한 작업 절차로 정리해줘. | 반복 작업 명세 |
| [합의된 연구 작업 명세](skills/to-spec/SKILL.md) | `$to-spec` | 지금까지 합의한 분석 절차를 입력 자료, 처리 단계, 산출물, 검증 기준이 명확한 작업 명세로 정리해줘. | 실행 가능한 작업 명세 |
| [장기 연구의 결정 지도](skills/wayfinder/SKILL.md) | `$wayfinder` | 이 장기 연구에서 먼저 결정해야 할 연구 질문, 방법, 자료와 검증 조건을 선후관계가 보이는 결정 지도로 정리해줘. | 의사결정 티켓 지도 |

### 선행연구·문헌 조사·근거 검증

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [1차 자료 기반 근거 조사](skills/research/SKILL.md) | `$research` | 이 연구 주제의 핵심 주장과 방법을 논문 원문, 공식 문서와 표준으로 확인해줘. 출처의 주장과 우리의 해석을 구분하고 확인되지 않은 부분을 표시해줘. | 출처가 연결된 근거 메모 · 원본 워크플로는 백그라운드 조사 에이전트 사용 |
| [연구 방법 학습·공유](skills/teach/SKILL.md) | `$teach` | 이 연구 방법을 대학원생이 이해할 수 있게 설명하고, 우리 분석에 적용할 전제와 한계, 이해를 확인할 질문을 포함해줘. | 방법 설명과 학습 기록 |

### 실험·분석 코드·재현성

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [분석 코드·명세 대조 검토](skills/code-review/SKILL.md) | `$code-review` | main 이후 분석 코드의 변경을 저장소 규칙과 합의된 분석 명세의 두 관점으로 검토해줘. 누락, 의도하지 않은 변경과 근거를 구분해줘. | 두 관점의 검토 결과 · 두 관점의 병렬 검토는 서브에이전트 지원 필요 |
| [분석 모듈의 책임·경계 설계](skills/codebase-design/SKILL.md) | `$codebase-design` | 전처리, 계산, 검증과 출력 모듈의 책임과 인터페이스를 정리하고 독립적으로 확인할 수 있는 경계를 제안해줘. | 모듈 인터페이스 설계 |
| [분석 오류의 재현·원인 확인](skills/diagnosing-bugs/SKILL.md) | `$diagnosing-bugs` | 이 분석 오류를 최소 사례로 재현하고 입력, 단위 변환과 계산 경로를 확인해 원인을 좁혀줘. 수정 후 같은 오류를 잡는 회귀 테스트를 남겨줘. | 재현 사례·원인·회귀 검증 |
| [연구 변수·개념 정의 정리](skills/domain-modeling/SKILL.md) | `$domain-modeling` | 이 분석 프로젝트에서 사용하는 변수와 개념의 의미를 정리하고, 혼용된 용어와 중복된 이름을 찾아 정의를 기록해줘. | 분석 용어집·정의 기록 |
| [분석 절차 구현](skills/implement/SKILL.md) | `$implement` | 합의된 분석 명세를 코드로 구현해줘. 입력, 단위, 제외 기준과 출력이 명세에 맞는지 확인하고 변경 내역을 기록해줘. | 분석 코드와 검증 결과 |
| [여러 분석 작업 통합](skills/implement-spec/SKILL.md) | `$implement-spec` | 이 분석 명세의 작업들을 의존관계에 맞춰 구현하고 하나의 PR로 통합해줘. 각 작업의 검증 결과를 함께 정리해줘. | 통합 PR·검증 기록 · 서브에이전트·Git worktree·PR 기능 필요 |
| [분석 코드 구조 개선 후보](skills/improve-codebase-architecture/SKILL.md) | `$improve-codebase-architecture` | 우리 분석 코드에서 검증이 어렵거나 수정이 여러 파일에 퍼지는 지점을 찾아 구조 개선 후보와 이유를 HTML 보고서로 보여줘. | 구조 개선 후보 보고서 |
| [분석 코드의 가정·변경 검증](skills/karpathy-guidelines/SKILL.md) | `$karpathy-guidelines` | 이 분석 코드의 가정과 모호한 요구사항을 먼저 설명하고, 필요한 범위만 수정한 뒤 결과가 검증 기준에 맞는지 확인해줘. | 가정·최소 변경·검증 결과 |
| [TypeScript 테스트 자료 정비](skills/migrate-to-shoehorn/SKILL.md) | `$migrate-to-shoehorn` | 이 TypeScript 분석 도구의 테스트에서 as 단언을 검토하고, 부분 테스트 자료를 shoehorn으로 표현해줘. | TypeScript 테스트 자료 · TypeScript 테스트와 @total-typescript/shoehorn 대상 |
| [분석 방법의 예비 구현](skills/prototype/SKILL.md) | `$prototype` | 이 분석 방법의 실행 가능성을 확인할 작은 예비 구현을 만들어줘. 실험적 구현에서 확인한 점과 본 분석에 아직 적용하지 않은 점을 구분해줘. | 예비 코드·확인 결과 |
| [공동 분석 코드 충돌 해결](skills/resolving-merge-conflicts/SKILL.md) | `$resolving-merge-conflicts` | 공동연구 분석 코드의 병합 충돌을 양쪽 변경의 목적에 맞게 해결하고 계산 의미가 보존되는지 확인해줘. | 충돌 해결·변경 의도 기록 |
| [분석 코드의 행동 검증](skills/tdd/SKILL.md) | `$tdd` | 이 계산 함수에 정상 입력, 경계값과 알려진 기준 사례의 실패 테스트를 먼저 작성한 뒤 구현해줘. | 행동 테스트·구현 |

### 결과 해석·논문 논증·원고 구성

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [발표·원고의 메시지 흐름](skills/writing-beats/SKILL.md) | `$writing-beats` | 이 연구 자료에서 문제, 방법 선택, 핵심 결과와 의미가 이어지는 메시지 흐름을 함께 구성해줘. 각 단계가 필요한 근거를 갖추는지 확인해줘. | 순서가 합의된 메시지 흐름 |
| [논문의 핵심 주장·근거 수집](skills/writing-fragments/SKILL.md) | `$writing-fragments` | 이 연구 결과로 논문에서 주장할 수 있는 내용과 뒷받침하는 관찰을 질문하면서 수집해줘. 근거가 있는 주장과 추가 검증이 필요한 주장을 구분해줘. | 주장·근거 소재 목록 |
| [논문 원고의 논증 구조](skills/writing-shape/SKILL.md) | `$writing-shape` | 이 결과와 소재 파일을 읽고 독자가 이해할 순서로 논문 원고를 문단별로 구성해줘. 원자료를 보존하고 각 문단의 주장과 근거를 확인해줘. | 논증이 연결된 원고 |

### 연구 시각화·학술 발표

연구 내용을 **어떤 형태로 전달하려는지**에 따라 도구를 선택합니다.

| 전달할 내용 | 도구와 종류 | 무엇을 만들어 주는가 | 대표 요청 |
|---|---|---|---|
| 연구 설계·자료 처리·분석·검증의 연결 | **Archify · 독립 스킬** | 단계, 분기, 입력·출력과 관계를 탐색할 수 있는 HTML 도식 | `$archify` 이 연구의 자료 수집 → 전처리 → 분석 → 검증 흐름을 도식으로 만들고, 단계별 입력과 산출물을 보여줘. |
| 실험값·조건별 차이·추세·불확실성 | **Visualize Data · 플러그인 포함 스킬** | 원자료에 근거한 논문용 그래프·정량 그림 | Visualize Data로 조건별 결과와 불확실성을 보여주는 그림을 만들고 축, 단위와 범례를 확인해줘. |
| 학회 발표·랩미팅·연구 결과 보고 | **Presentations · 플러그인 포함 스킬** | 연구 질문, 방법, 결과와 의미가 이어지는 발표 슬라이드 | Presentations로 이 연구의 질문, 방법, 핵심 결과와 한계를 담은 학회 발표 자료를 만들어줘. |
| 기존 Google Slides 발표 자료 수정 | **Google Slides · 플러그인 포함 스킬** | 제공된 발표 덱의 구조·스타일을 유지한 수정본 | Google Slides로 이 발표 덱의 스타일을 유지하면서 새로운 결과와 그림을 반영해줘. |

Archify는 [원본 저장소](https://github.com/tt-a1i/archify)에서 따로 설치합니다. Visualize Data·Presentations·Google Slides는 Codex 플러그인으로 연결합니다.


### 공동연구·과제 운영·인수인계

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [Claude Code 작업 인계](skills/claude-handoff/SKILL.md) | `$claude-handoff` | 현재 분석의 목적, 완료한 작업과 남은 작업을 정리해 Claude Code의 새 백그라운드 에이전트에 인계해줘. | Claude Code 작업 인계 · Claude Code CLI와 해당 버전의 --bg 지원 필요 |
| [연구 업무 인수인계](skills/handoff/SKILL.md) | `$handoff` | 다른 연구자가 이 분석을 이어갈 수 있도록 연구 목적, 입력 자료, 현재 결과, 결정 이유, 미해결 사항과 다음 작업을 인수인계 문서로 정리해줘. | 연구 인수인계 문서 |
| [연구 작업 회고·절차 개선](skills/retro/SKILL.md) | `$retro` | 이번 분석 작업에서 반복된 문제와 검증 누락을 회고하고 다음 작업을 위한 환경과 지침 개선점을 제안해줘. | 작업 회고·개선안 |
| [공동연구자 확인 질문지](skills/to-questionnaire/SKILL.md) | `$to-questionnaire` | 공동연구자에게 확인해야 할 측정 조건, 자료 처리 기준과 해석상의 쟁점을 질문지로 정리해줘. 받는 사람이 제공할 정보와 결정할 사항을 구분해줘. | 역할별 확인 질문지 |
| [공동연구 작업 분담 명세](skills/to-tickets/SKILL.md) | `$to-tickets` | 이 연구 분석 명세를 독립적으로 완료할 작업으로 나누고, 각 작업의 산출물, 완료 기준과 선행 작업을 명시해줘. | 의존관계가 있는 작업 티켓 |
| [공동연구 요청·오류 접수 정리](skills/triage/SKILL.md) | `$triage` | 공동연구자가 접수한 분석 오류와 개선 요청을 분류하고, 재현 자료와 필요한 확인 사항을 갖춘 작업 요청으로 정리해줘. | 정리된 요청·오류 티켓 |
| [연구 맥락에 맞춘 재설명](skills/wait-what/SKILL.md) | `$wait-what` | 방금 설명을 연구 목적과 변수 정의부터 다시 설명해줘. 동료 연구자가 이해할 수 있도록 전문 용어의 의미를 먼저 밝혀줘. | 맥락과 용어를 풀어 쓴 설명 |

### 연구 도구·실행 환경 구축

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [Claude Code의 Git 보호 설정](skills/git-guardrails-claude-code/SKILL.md) | `$git-guardrails-claude-code` | 이 연구 프로젝트의 Claude Code 환경에 위험한 Git 명령을 차단하는 훅을 설정해줘. | Claude Code Git 보호 훅 · Claude Code 훅용. Codex 자체의 Git 차단 설정은 아님; Bash 필요 |
| [AI Hero 교육 실습 구조](skills/scaffold-exercises/SKILL.md) | `$scaffold-exercises` | AI Hero 교육 과정 규칙을 사용하는 프로젝트에서 연구 분석 교육용 실습 문제와 해설 폴더를 만들어줘. | AI Hero 전용 실습 구조 · AI Hero 과정 구조와 pnpm ai-hero-cli 환경을 사용하는 전용 스킬 |
| [연구 프로젝트의 작업·문서 체계](skills/setup-matt-pocock-skills/SKILL.md) | `$setup-matt-pocock-skills` | 이 연구 프로젝트에서 사용할 작업 추적 방식, 요청 분류와 개념·결정 기록 체계를 설정해줘. | 프로젝트 작업·문서 설정 |
| [분석 코드 커밋 전 검사](skills/setup-pre-commit/SKILL.md) | `$setup-pre-commit` | 이 분석 도구 프로젝트에 커밋 전 포맷, 타입과 필요한 테스트 검사를 설정해줘. | 커밋 전 자동 검사 · Node.js와 프로젝트 패키지 관리자 필요 |
| [TypeScript 분석 도구의 접근 규칙](skills/setup-ts-deep-modules/SKILL.md) | `$setup-ts-deep-modules` | 이 TypeScript 분석 도구의 패키지 공개 진입점과 내부 접근 규칙을 설정하고 규칙이 실제로 동작하는지 확인해줘. | 모듈 접근 규칙 · TypeScript·Node.js 프로젝트와 dependency-cruiser 필요 |
| [연구 도구의 수동 설정 안내](skills/wizard/SKILL.md) | `$wizard` | 연구 도구 설정에서 사람이 직접 해야 하는 로그인과 인증 단계만 안내하는 Bash 스크립트를 만들어줘. | 수동 설정 안내 스크립트 · 생성된 스크립트는 Bash 필요(Windows: Git Bash/WSL) |
| [연구용 에이전트 지침 정비](skills/writing-for-agents/SKILL.md) | `$writing-for-agents` | 연구실에서 반복 사용하는 에이전트 지침을 검토하고, 자료 확인 조건, 산출물과 완료 기준이 명확하게 정리되도록 수정해줘. | 재사용 가능한 에이전트 지침 |



### 논문 투고·사전 심사·수정 검증

아래 세 스킬은 **진입 스킬**입니다. 실제 심사는 각 원본 도구를 따로 설치해야 동작합니다.

| 연구에서 필요한 검토 | 도구와 실제 호출 | 기대하는 산출물 |
|---|---|---|
| 목표 저널의 범위·최근 논문·요구사항에 맞는지 검토 | **Agentic Reviewer** · `$review-paper` | 저널 조사, 적합성·연구방법·통계·서술·윤리 검토와 종합 보고서 |
| 서로 다른 모델이 공통으로 지적하는 문제와 개별 지적을 비교 | **AI Peer Review** · `$ai-peer-review` | 모델별 독립 심사, 종합 심사평, 쟁점별 모델 비교 CSV/JSON |
| 수정본이 이전 심사의 지적을 실제로 해결했는지 검증 | **paper-reviewer** · `$paper-reviewer` | 이전 지적별 상태·수정 근거, 버전별 심사평·편집자 결정과 쟁점 이력 |


원본: [Agentic Reviewer](https://github.com/FilippoScaramuzza/agentic-reviewer) · [AI Peer Review](https://github.com/poldrack/ai-peer-review) (Python 3.13 이상, 모델 제공자 API 키 필요) · [paper-reviewer](skills/paper-reviewer/SKILL.md)의 원본 링크 참고.
