#  AI 스킬 모음

 AI 스킬을 **ChatGPT(Codex)용**과 **Claude용**으로 나눠 모았습니다.
스킬은 AI가 반복 작업(연구 설계 검토, 논문 작성, 통계 분석, 코드 검토 등)을 같은 방식으로 하도록 적어 둔 지침 파일입니다.

| 쓰는 AI | 폴더 | 스킬 수 | 설치 방법 | 호출 |
|---|---|---|---|---|
| ChatGPT · Codex | [chatgpt/](chatgpt/README.md) | 41 | `python scripts/install.py` → `~/.agents/skills` | `$스킬명` |
| Claude 앱 (채팅) | [claude/](claude/README.md) | 44 | `claude/zips/`의 zip을 설정 → Skills에 업로드 | “스킬명 스킬로 …” |
| Claude Code | [claude/](claude/README.md) | 44 | `claude/install.ps1` 또는 `install.sh` | `/스킬명` |

각 폴더의 README에 **설치 방법, 스킬별 의미, 호출 방법, 연구에서 쓰는 때**를 표로 정리했습니다.

## 바로 시작하기

```bash
git clone https://github.com/ji0eeeee/Skills_.git
```

- ChatGPT(Codex)를 쓰면 → [chatgpt/README.md](chatgpt/README.md)
- Claude를 쓰면 → [claude/README.md](claude/README.md)
- 둘 다 쓰면 두 쪽 모두 설치해도 서로 겹치지 않습니다 (설치 위치가 다름).

## 함께 알아 둘 것

- 스킬은 범용 지침을 연구에 맞게 소개한 것입니다. 분야별 방법·통계 타당성은 연구자가 확인합니다.
- AI가 찾은 문헌은 DOI와 원문을 확인한 뒤 인용합니다.
- 미발표 자료, IRB 대상 자료, 심사 중인 원고를 올리기 전에 소속 기관과 저널의 AI 사용 규정을 확인합니다.
- 각 스킬 폴더의 LICENSE 파일에 원 출처의 라이선스가 있습니다.
