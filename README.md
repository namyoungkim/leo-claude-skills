# Leo's Claude Skills

개인 Claude Skills 저장소. Claude Code, Claude.ai, API에서 사용.

## 📦 Skills 목록

| Skill | 설명 | 트리거 |
|-------|------|--------|
| [python-project](./python-project/) | Python 프로젝트 세팅 (uv + ruff + ty) | "파이썬 프로젝트 만들어줘" |
| [coding-problem-solver](./coding-problem-solver/) | 코딩 인터뷰 문제 풀이 정리 | LeetCode 링크, "문제 풀어줘" |

## 🚀 사용 방법

### Claude Code (권장)

```bash
# 1. 저장소 클론
git clone https://github.com/YOUR_USERNAME/leo-claude-skills.git ~/leo-claude-skills

# 2. 심볼릭 링크 생성 (초기 1회)
./scripts/sync-to-claude-code.sh

# 3. 업데이트 시
cd ~/leo-claude-skills && git pull
```

### Claude.ai

```bash
# 1. 스킬 폴더를 ZIP으로 압축
zip -r python-project.zip python-project/

# 2. Claude.ai > Settings > Features > Skills > Upload skill
```

## 📂 구조

```
leo-claude-skills/
├── README.md
├── python-project/
│   └── SKILL.md
├── coding-problem-solver/
│   ├── SKILL.md
│   └── references/
│       └── output-template.md
└── scripts/
    └── sync-to-claude-code.sh
```

## 🔧 새 스킬 추가

```bash
# 1. 폴더 생성
mkdir new-skill

# 2. SKILL.md 작성
cat > new-skill/SKILL.md << 'EOF'
---
name: new-skill
description: 스킬 설명. 트리거 조건 포함.
---

# New Skill

내용...
EOF

# 3. 동기화
./scripts/sync-to-claude-code.sh
```

## 📋 스킬 작성 가이드

### SKILL.md 필수 요소

```yaml
---
name: skill-name          # 64자 이내
description: ...          # 200자 이내, 트리거 조건 포함
---
```

### 권장 사항

- **Progressive Disclosure**: 핵심만 SKILL.md에, 상세는 references/로
- **구체적 트리거**: "파이썬 프로젝트" 대신 "파이썬 프로젝트 만들어줘", "Python 세팅" 등
- **500줄 이내**: 넘으면 references/로 분리

## 📝 변경 이력

- 2025-12-26: python-project, coding-problem-solver 초기 추가
