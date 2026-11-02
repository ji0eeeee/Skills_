# Claude 스킬 안내

Claude(claude.ai 채팅·데스크톱·모바일 앱, Claude Code)에서 쓰는 스킬 50개입니다.
스킬은 Claude가 반복 작업을 같은 방식으로 하도록 적어 둔 지침 파일(`skills/<이름>/SKILL.md`)입니다. 설치하면 요청에 맞는 스킬을 Claude가 자동으로 고르고, 이름으로 직접 부를 수도 있습니다.

범용 지침을 연구에 맞게 소개한 것이며, 분야별 방법·통계·실험 타당성을 자동으로 보장하지 않습니다.

## 어디서 쓸지 고르기

| | Claude 앱 (채팅) | Claude Code (코딩 에이전트) |
|---|---|---|
| 잘 맞는 일 | 문헌 읽기, 연구 설계 토론, 원고 작성·교정, 발표 구성 | 분석 코드, 재현 가능한 파이프라인, 그림 생성, 저장소 작업 |
| 설치 | `zips/`의 zip을 설정 → Skills에 업로드 | `install.ps1` / `install.sh` 실행 |
| 다른 기기 | 계정에 저장되어 모든 기기에 적용 | 컴퓨터마다 설치 |
| 호출 | “scientific-writing 스킬로 …” | `/scientific-writing …` |

둘 다 쓰면 둘 다 설치합니다. 스킬 이름 없이 요청해도 설명이 맞는 스킬을 Claude가 자동으로 고릅니다.

## 설치 1 — Claude 앱 (설정 → Skills 업로드)

1. 이 저장소에서 [zips/](zips/) 폴더의 zip을 받습니다. GitHub 저장소 첫 화면의 **Code → Download ZIP**으로 전체를 받으면 편합니다.
2. claude.ai **설정 → Capabilities**에서 **Code execution(코드 실행)**을 켭니다.
3. 같은 화면의 **Skills → Upload skill**에서 필요한 스킬의 zip을 하나씩 올립니다. zip은 **풀지 않고 그대로** 올립니다.

채팅에서는 로컬 파일·Git·외부 API 호출이 제한됩니다. 코드 리뷰, 커밋, 저장소 설정 계열은 Claude Code에서 쓰는 편이 낫습니다.
pptx, docx, xlsx, pdf, skill-creator는 Anthropic 기본 스킬로 이미 들어 있어서 여기에 넣지 않았습니다.

## 설치 2 — Claude Code

먼저 [Claude Code](https://claude.com/claude-code)를 설치합니다. 그다음 저장소를 받아 스크립트를 실행합니다.

```bash
git clone https://github.com/ji0eeeee/Skills_.git
```

**Windows (PowerShell)**

```powershell
powershell -ExecutionPolicy Bypass -File Skills_\claude\install.ps1
```

**macOS · Linux**

```bash
sh Skills_/claude/install.sh
```

스크립트가 하는 일 (이미 있는 것은 건너뜀)

1. uv(파이썬 도구 설치기)를 설치합니다.
2. Ponytail 플러그인, Humanize KR(im-not-ai) 플러그인, Graphify, Headroom을 설치합니다 ([아래 표](#함께-설치하는-도구)).
3. `skills/`의 나머지 스킬을 `~/.claude/skills/`에 복사합니다. 플러그인이 주는 ponytail*·humanize*는 복사하지 않고, 같은 이름의 폴더가 있으면 덮어쓰지 않습니다.

스킬만 복사하려면 `-SkipTools` / `--skip-tools`, 도구만 설치하려면 `-SkipSkills` / `--skip-skills`를 붙입니다.

## 연구 단계별로 고르기

| 지금 하려는 일 | 먼저 쓸 스킬 | 기대할 결과 |
|---|---|---|
| 어떤 스킬부터 쓸지 모르겠음 | ask-matt | 연구 단계별 실행 순서 |
| 논문 원고를 쓰거나 고침 | scientific-writing · scientific-critical-thinking · doc-coauthoring | IMRAD 원고, 근거 수준 평가 |
| 통계 분석·실험 설계 | statistical-analysis · senior-data-scientist | 검정 선택, 가정 확인, APA 보고 |
| 투고 전 심사 | ai-peer-review · scientific-critical-thinking | 모델별 지적 비교, 방법론 약점 |
| 발표·그림 | scientific-slides · draw-io · canvas-design | 발표 자료, 절차 도식, 포스터 |
| 분석 코드 구현·검토 | implement · code-reviewer · karpathy-guidelines | 작게 검증된 코드 |
| AI 답을 그대로 믿어도 될지 | discernment-nudge | 확인할 점과 한계 표시 |
| AI가 쓴 한국어 글이 번역투·기계적임 | humanize-korean · humanize-scan | 자연스러운 한국어 윤문, AI 티 진단 |
| 웹페이지·랜딩 페이지를 새로 만듦 | hallmark · frontend-design | 템플릿 같지 않은 디자인 |
| 연구 소개 영상을 코드로 만듦 | remotion-best-practices | Remotion(React) 영상 프로젝트 |
| 대화가 길어져 사용량이 빨리 줄어듦 | graphify · handoff · ponytail | 적게 읽고 짧게 답하고 새 세션으로 넘김 |

## 스킬별 의미·호출·쓰는 때

호출은 Claude Code 기준(`/스킬명`)입니다. Claude 앱에서는 “스킬명 스킬로 …”처럼 요청합니다.

### 연구 질문·설계·진행 방향

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [연구 단계별 도구 선택](skills/ask-matt/SKILL.md) | `/ask-matt` | 지금 연구가 어느 단계인지 보고 어떤 스킬을 어떤 순서로 쓸지 제안해줘. | 스킬 실행 순서 |
| [요구사항 인터뷰](skills/loop-me/SKILL.md) | `/loop-me` | 내가 만들려는 분석 자동화 흐름을 질문으로 하나씩 구체화해줘. | 합의된 작업 명세 |
| [엄격한 연구 엔지니어 관점](skills/research-engineer/SKILL.md) | `/research-engineer` | 이 방법의 이론적 정확성과 구현 선택을 비판적으로 검토해줘. | 이론·구현 비판 |

### 논문 원고·논증·심사

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [과학 논문 작성](skills/scientific-writing/SKILL.md) | `/scientific-writing` | 이 결과로 Methods와 Results 절을 IMRAD 형식의 문단으로 써줘. 인용은 APA로 해줘. | 개요 → 완성 문단, 보고 지침(CONSORT 등) 반영 |
| [연구 엄밀성 평가](skills/scientific-critical-thinking/SKILL.md) | `/scientific-critical-thinking` | 이 논문의 설계, 편향, 교란요인과 근거 수준(GRADE)을 평가해줘. | 방법론 약점과 근거 등급 |
| [다중 모델 사전 심사](skills/ai-peer-review/SKILL.md) | `/ai-peer-review` | 이 원고를 여러 모델로 심사받고 공통 지적과 모델별 지적을 나눠줘. | 모델별 심사 비교 (AI Peer Review CLI 필요) |
| [문서 공동 작성 절차](skills/doc-coauthoring/SKILL.md) | `/doc-coauthoring` | 연구계획서 초안을 같이 쓰자. 필요한 맥락을 먼저 묻고 절별로 다듬어줘. | 단계별로 다듬은 문서 |
| [AI 답 점검 알림](skills/discernment-nudge/SKILL.md) | `/discernment-nudge` | (자동) 계획·분석·주장처럼 그대로 따를 답을 줄 때 확인할 점을 함께 알려줌 | 확인할 가정과 한계 |

### 한국어 글 다듬기 (Humanize KR)

[im-not-ai](https://github.com/epoko77-ai/im-not-ai)의 스킬입니다. Claude Code에서는 플러그인으로 설치하면 진단·윤문을 따로 맡는 서브에이전트까지 함께 들어옵니다. Claude 앱에 zip으로 올리면 단일 호출 방식으로 동작합니다.

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [AI 티 없애기 윤문](skills/humanize-korean/SKILL.md) | `/humanize-korean` | 이 논문 초록의 번역투와 AI 같은 문체를 자연스러운 한국어로 고쳐줘. 내용과 수치는 바꾸지 마. | 윤문한 글 (분량에 따라 light·standard·heavy 경로) |
| [짧게 부르기](skills/humanize/SKILL.md) | `/humanize` | `/humanize` 이 연구계획서 문단 다듬어줘. | humanize-korean과 같음 |
| [AI 티 진단만](skills/humanize-scan/SKILL.md) | `/humanize-scan` | 이 글이 AI가 쓴 것처럼 보이는지 진단만 하고 고치지는 마. | 번역투·기계적 표현 목록 |
| [다시 윤문](skills/humanize-redo/SKILL.md) | `/humanize-redo` | 방금 윤문이 아직 딱딱해. 다시 해줘. | 다시 다듬은 글 |

### 통계·데이터 분석

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [통계 검정·보고](skills/statistical-analysis/SKILL.md) | `/statistical-analysis` | 두 집단 비교에 맞는 검정을 고르고 가정을 확인한 뒤 APA 형식으로 보고해줘. | t-test·ANOVA·회귀·검정력 분석 |
| [데이터 과학 모델링](skills/senior-data-scientist/SKILL.md) | `/senior-data-scientist` | 이 데이터로 인과 추론이 가능한지 보고 실험 설계나 모델을 제안해줘. | 실험 설계, 예측·인과 모델 |

### 시각화·발표·디자인

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [학술 발표 자료](skills/scientific-slides/SKILL.md) | `/scientific-slides` | 15분 학회 발표용 슬라이드 구성과 시간 배분을 만들어줘. | PowerPoint·Beamer 발표 자료 |
| [절차 도식](skills/draw-io/SKILL.md) | `/draw-io` | 실험 절차를 draw.io 다이어그램으로 그리고 PNG로 내보내줘. | .drawio 파일·PNG |
| [포스터·정적 그림](skills/canvas-design/SKILL.md) | `/canvas-design` | 학회 포스터 배경과 핵심 도식을 PNG로 만들어줘. | PNG·PDF 디자인 |
| [코드로 만든 그림](skills/algorithmic-art/SKILL.md) | `/algorithmic-art` | 연구 데이터를 모티프로 한 생성형 그림을 p5.js로 만들어줘. | p5.js 생성 그림 |
| [일관된 테마 적용](skills/theme-factory/SKILL.md) | `/theme-factory` | 이 발표 자료와 보고서에 같은 색·글꼴 테마를 입혀줘. | 10가지 테마 중 선택 적용 |
| [Anthropic 브랜드 스타일](skills/brand-guidelines/SKILL.md) | `/brand-guidelines` | 이 문서를 Anthropic 색·글꼴로 꾸며줘. | Anthropic 스타일 (연구실 용도로는 거의 안 씀) |
| [화면 디자인 방향](skills/frontend-design/SKILL.md) | `/frontend-design` | 연구 결과 대시보드 화면을 기본 템플릿처럼 보이지 않게 디자인해줘. | UI 디자인 방향 |
| [복잡한 웹 결과물](skills/web-artifacts-builder/SKILL.md) | `/web-artifacts-builder` | 실험 조건을 바꿔 보는 대화형 결과 페이지를 React로 만들어줘. | 여러 화면의 HTML 결과물 |
| [Slack용 GIF](skills/slack-gif-creator/SKILL.md) | `/slack-gif-creator` | 연구실 Slack에 올릴 실험 장비 작동 GIF를 만들어줘. | Slack 규격 GIF |
| [디자인된 웹페이지](skills/hallmark/SKILL.md) | `/hallmark` | `/hallmark` 우리 연구실 소개 페이지를 새로 만들어줘. 생성형 템플릿처럼 보이지 않게. | 디자인된 새 페이지, 자동 품질 검사(sloplint) · 기존 페이지는 `/hallmark redesign <경로>`처럼 이름을 붙일 때만 |
| [Remotion 영상 제작](skills/remotion-best-practices/SKILL.md) | `/remotion-best-practices` | 연구 결과를 1분짜리 설명 영상으로 만드는 Remotion 프로젝트를 만들어줘. | React 코드로 만든 영상 · Node.js와 Remotion 필요 |

### 분석 코드 구현·검토

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [명세대로 구현](skills/implement/SKILL.md) | `/implement` | 이 분석 계획서대로 전처리 코드를 구현해줘. | 계획서 기반 코드 |
| [스펙 구현](skills/implement-spec/SKILL.md) | `/implement-spec` | 이 사양 문서를 코드로 옮기고 테스트를 붙여줘. | 사양 → 코드 |
| [코드 리뷰](skills/code-reviewer/SKILL.md) | `/code-reviewer` | 이 분석 스크립트를 검토해 버그와 보안 문제를 찾아줘. | 리뷰 체크리스트, 발견 사항 |
| [실수 줄이는 코딩 지침](skills/karpathy-guidelines/SKILL.md) | `/karpathy-guidelines` | 이 코드를 고칠 때 가정을 먼저 밝히고 최소한만 바꿔줘. | 작고 검증 가능한 변경 |
| [구조 개선](skills/improve-codebase-architecture/SKILL.md) | `/improve-codebase-architecture` | 분석 코드베이스에서 정리할 구조를 찾아 HTML 보고서로 보여줘. | 구조 개선 보고서 |
| [커밋 메시지](skills/git-commit-helper/SKILL.md) | `/git-commit-helper` | 지금 바뀐 내용으로 커밋 메시지를 써줘. | 커밋 메시지 |
| [프롬프트 설계](skills/senior-prompt-engineer/SKILL.md) | `/senior-prompt-engineer` | 문헌 요약용 프롬프트를 구조화된 출력이 나오게 다듬어줘. | 프롬프트·평가 기준 |
| [웹 앱 테스트](skills/webapp-testing/SKILL.md) | `/webapp-testing` | 로컬에서 띄운 분석 대시보드를 Playwright로 눌러 보고 화면을 캡처해줘. | 동작 확인·스크린샷 |
| [MCP 서버 만들기](skills/mcp-builder/SKILL.md) | `/mcp-builder` | 연구실 데이터베이스를 Claude가 조회할 수 있게 MCP 서버를 만들어줘. | MCP 서버 코드 |

### 인수인계·공유·세션 관리

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [인수인계 문서](skills/handoff/SKILL.md) | `/handoff` | 지금까지 한 분석과 남은 일을 다음 세션이 이어받을 수 있게 정리해줘. | 인수인계 문서 |
| [백그라운드로 넘기기](skills/bg-agent-handoff/SKILL.md) | `/bg-agent-handoff` | 이 작업을 백그라운드 에이전트에게 넘겨 계속 진행해줘. | 새 백그라운드 세션 |
| [사람이 해야 할 단계 안내](skills/wizard/SKILL.md) | `/wizard` | 서버 계정 설정처럼 내가 직접 해야 하는 단계를 대화형 bash 마법사로 만들어줘. | 단계별 bash 스크립트 |
| [연구실 공지·보고](skills/internal-comms/SKILL.md) | `/internal-comms` | 이번 주 실험 진행 상황을 연구실 공유용 보고로 정리해줘. | 상태 보고·공지 초안 |

### 개발 환경 준비

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [엔지니어링 스킬 초기 설정](skills/setup-matt-pocock-skills/SKILL.md) | `/setup-matt-pocock-skills` | 이 저장소에 이슈 트래커와 문서 구조를 설정해줘. | 저장소 설정 파일 |
| [커밋 전 검사](skills/setup-pre-commit/SKILL.md) | `/setup-pre-commit` | 커밋할 때 포맷·타입 검사·테스트가 돌도록 설정해줘. | Husky·lint-staged 설정 |
| [TypeScript 모듈 경계](skills/setup-ts-deep-modules/SKILL.md) | `/setup-ts-deep-modules` | 패키지 내부 구현을 숨기도록 dependency-cruiser를 연결해줘. | 의존성 규칙 |
| [연습문제 구조](skills/scaffold-exercises/SKILL.md) | `/scaffold-exercises` | 통계 수업용 연습문제와 해설 폴더 구조를 만들어줘. | 문제·해설 폴더 |

### Claude 사용법 익히기

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [Claude 학습 자료 추천](skills/academy-guide/SKILL.md) | `/academy-guide` | Claude로 논문 리뷰하는 법을 배우고 싶어. 맞는 강의를 추천해줘. | Claude Academy 강의·튜토리얼 |

### 사용량 절약 (Ponytail·Graphify)

| 연구 업무 | 실제 호출 | 대표 요청 | 산출물·적용 범위 |
|---|---|---|---|
| [프로젝트 지식 그래프](skills/graphify/SKILL.md) | `/graphify` | `/graphify .` 이 연구 저장소 구조를 그래프로 만들고 핵심 파일을 알려줘. | graphify-out/ 그래프 (Graphify 설치 필요) |
| [최소 변경 모드](skills/ponytail/SKILL.md) | `/ponytail` | 이 분석 코드를 가장 작은 변경으로 고쳐줘. | 짧은 수정과 답 |
| [변경 검토](skills/ponytail-review/SKILL.md) | `/ponytail-review` | 방금 고친 코드를 검토해줘. | 쉬운 말로 쓴 검토 결과 |
| [저장소 전체 점검](skills/ponytail-audit/SKILL.md) | `/ponytail-audit` | 이 저장소 전체에서 버그·보안 문제와 지울 코드를 찾아줘. | 순위가 매겨진 점검 보고 (수정 없음) |
| [미뤄 둔 작업 목록](skills/ponytail-debt/SKILL.md) | `/ponytail-debt` | `shortcut:` 주석으로 미뤄 둔 것들을 모아줘. | 미룬 작업 목록 |
| [절약 효과](skills/ponytail-gain/SKILL.md) | `/ponytail-gain` | Ponytail이 얼마나 아껴 주는지 보여줘. | 측정된 절약 수치 |
| [Ponytail 도움말](skills/ponytail-help/SKILL.md) | `/ponytail-help` | Ponytail 사용법 알려줘. | 명령·단계 요약 |

## 함께 설치하는 도구

Claude Code에서 쓰는 도구입니다. `install.ps1` / `install.sh`가 설치합니다.

| 도구 | 하는 일 | 사용법 |
|---|---|---|
| Ponytail | 가장 작은 변경으로 문제를 풀고 짧게 답하게 함 | 설치 후 자동 적용. `/ponytail-help` |
| Graphify | 프로젝트를 지식 그래프로 만들어 Claude가 파일을 매번 다시 읽지 않게 함 | 프로젝트 폴더에서 `/graphify .` |
| Humanize KR | 한국어 윤문 스킬 4개 + 서브에이전트 | `/humanize-korean` (플러그인: `humanize-korean@im-not-ai`) |
| Headroom | Claude에 보내는 내용을 압축하는 중계기(프록시) | 터미널에서 `headroom wrap claude` (데스크톱 앱 세션은 아직 미지원) |

## 출처와 라이선스

- ask-matt, handoff, implement 등 Matt Pocock 스킬: MIT (각 폴더의 LICENSE)
- academy-guide, canvas-design 등 Anthropic 예제 스킬: Apache 2.0 (각 폴더의 LICENSE.txt)
- ponytail: MIT · [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail)
- humanize-korean·humanize·humanize-scan·humanize-redo: MIT · [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai)
- hallmark: MIT · [Nutlope/hallmark](https://github.com/Nutlope/hallmark) (브라우저 검사는 Node 18+, puppeteer-core, Chrome 필요)
- remotion-best-practices: [remotion-dev/skills](https://github.com/remotion-dev/skills) · Remotion 자체는 회사 규모에 따라 유료 라이선스가 필요할 수 있음 ([remotion.dev/license](https://www.remotion.dev/license))
- graphify: [graphifyy](https://pypi.org/project/graphifyy/) 설치 시 만들어지는 스킬
- 나머지(scientific-*, statistical-analysis, code-reviewer 등)는 개별 원본과 라이선스를 확인 중입니다. [확인 현황](../LICENSE_STATUS.md)을 참고하세요.
