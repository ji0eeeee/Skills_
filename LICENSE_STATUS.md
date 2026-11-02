# 스킬 출처와 라이선스 확인 현황

스킬별 라이선스 조건은 서로 다르며, 아래에서 확인되지 않은 항목에 사용·재배포 권한이 있다고 추정하면 안 됩니다. 원본 스킬을 수정한 진입 스킬과 별도 실행 도구는 각각의 권리를 확인해야 합니다. 라이선스 파일이 있더라도 포함된 제3자 자료에 별도 조건이 적용될 수 있습니다.

## 이번에 확인한 출처

| 스킬 | 확인한 원본 | 적용 범위 및 조건 |
|---|---|---|
| idea-spark, paper-search, scoop-check, paper2assets, paper2blog, paper2poster, paper2reel, paper2video | [Microsoft ResearchStudio](https://github.com/microsoft/ResearchStudio/blob/main/LICENSE) | MIT. 각 폴더에 원문을 추가했습니다. paper2poster의 KaTeX, MathJax, 글꼴 등은 각 보조 자료의 라이선스도 확인하세요. |
| research-add-fields, research-add-items, research-deep, research-report | [Weizhena/Deep-Research-skills](https://github.com/Weizhena/Deep-Research-skills/blob/main/LICENSE) | MIT. 각 폴더에 원문을 추가했습니다. |
| academic-research-suite | [ARS-Codex](https://github.com/Imbad0202/academic-research-skills-codex/blob/main/LICENSE) | CC BY-NC 4.0: 출처 표시와 비상업적 이용 조건이 있습니다. 포함된 자료에는 별도 조건이 있을 수 있습니다. |
| ponytail 및 ponytail-* | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail/blob/main/LICENSE) | MIT. 폴더와 Claude 업로드 ZIP에 원문을 추가했습니다. |
| humanize, humanize-scan, humanize-redo | [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai/blob/main/LICENSE) | MIT. 폴더와 Claude 업로드 ZIP에 원문을 추가했습니다. |
| ChatGPT: codex-handoff, git-guardrails-codex, primary-source-research | [mattpocock/skills](https://github.com/mattpocock/skills) (`claude-handoff`, `git-guardrails-claude-code`, `research`를 Codex용으로 고친 것) | MIT (Copyright 2026 Matt Pocock). 각 폴더에 원문을 추가했습니다. |
| ChatGPT: pptx2video | [ai-nuts/pptx2video](https://github.com/ai-nuts/pptx2video/blob/main/LICENSE) `3c43431` | MIT. SKILL.md가 원본과 같습니다. 폴더에 원문을 추가했습니다. |
| Claude: scientific-critical-thinking, scientific-slides, scientific-writing, statistical-analysis | [K-Dense-AI/claude-scientific-skills](https://github.com/K-Dense-AI/claude-scientific-skills/blob/main/LICENSE.md) `5f2bc03` | MIT (원본 frontmatter에도 MIT 표시). claude-code-templates를 거쳐 받아 원본과 내용이 일부 다릅니다. 폴더와 ZIP에 `LICENSE.md`를 추가했습니다. |
| Claude: code-reviewer, senior-data-scientist, senior-prompt-engineer | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills/blob/main/LICENSE) `e4a1dc3` | MIT. 폴더와 ZIP에 원문을 추가했습니다. |
| Claude: draw-io, git-commit-helper, research-engineer | [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates/blob/main/LICENSE) `c260224` | MIT. SKILL.md가 원본과 같습니다. 이 저장소보다 앞선 원작자 표시는 찾지 못했습니다. 폴더와 ZIP에 원문을 추가했습니다. |
| Claude: graphify | [safishamsi/graphify](https://github.com/safishamsi/graphify) `32e5efe` | Apache-2.0 (재라이선스 전 기여분은 MIT). `LICENSE`, `LICENSE-MIT`, `NOTICE`를 폴더와 ZIP에 추가했습니다. Apache-2.0은 재배포 시 NOTICE 유지와 변경 사실 표시가 필요합니다. |

## 추가 확인이 필요한 항목

아래는 스킬 폴더 최상위에 라이선스 원문이 없는 항목입니다. 원본이 알려져 있어도 해당 스킬 또는 이 저장소의 수정본에 적용할 라이선스 원문과 범위를 확인하지 못한 경우 포함합니다. 도구 자체의 라이선스가 이 저장소의 진입 스킬 라이선스를 자동으로 정해주지는 않습니다.

- ChatGPT·Claude: ai-peer-review, ChatGPT: paper-reviewer, review-paper — [project_skills](https://github.com/ji0eeeee/project_skills)에서 직접 작성한 진입 스킬입니다. 원본 도구의 파일은 포함하지 않으며, 진입 스킬 자체의 라이선스는 작성자가 정해야 합니다. 원본 도구: [poldrack/ai-peer-review](https://github.com/poldrack/ai-peer-review)(MIT), [sohan-shingade/paper-reviewer](https://github.com/sohan-shingade/paper-reviewer)(고정 커밋 `6a5c484`에 라이선스 파일 없음), [Agentic Reviewer](https://github.com/FilippoScaramuzza/agentic-reviewer)(별도 확인 필요).
- ChatGPT·Claude: karpathy-guidelines — [원본](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md)이 MIT라고 표시하지만, 저작권 고지가 있는 라이선스 원문이 원본 저장소에 없어 파일을 추가하지 않았습니다.
- Claude: doc-coauthoring — [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/doc-coauthoring)의 다른 스킬과 달리 이 폴더에는 `LICENSE.txt`가 없습니다(`ca45fc4` 기준).
- Claude: remotion-best-practices — [remotion-dev/skills](https://github.com/remotion-dev/skills)에 라이선스 파일이 없습니다(`c7cb2fd` 기준). Remotion 자체는 [별도 라이선스](https://www.remotion.dev/license)(직원 3명 초과 회사는 유료)입니다.

각 항목은 원본 게시자에게 라이선스를 문의하거나 작성자가 라이선스를 정한 뒤 보완하세요.

이 문서는 전체 폴더의 모든 파일에 대한 권리 검토나 법률 자문이 아닙니다.
