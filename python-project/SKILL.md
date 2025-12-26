---
name: python-project
description: Python 프로젝트 초기화 및 세팅 가이드. uv + ruff + ty + pytest 기반 Astral Toolchain 사용. 프로젝트 생성, pyproject.toml 설정, VSCode 설정, 코드 컨벤션 적용 시 트리거. "파이썬 프로젝트 만들어줘", "Python 세팅", "새 프로젝트 초기화" 등의 요청 시 사용.
---

# Python Project Setup

Leo의 Python 프로젝트 표준 세팅. Astral Toolchain (uv + ruff + ty) 기반.

## 도구 스택

| 도구 | 용도 | 버전 |
|------|------|------|
| uv | 패키지 매니저 + 프로젝트 관리 | latest |
| ruff | Linter + Formatter | >=0.14 |
| ty | Type Checker (CLI) | >=0.0.7 (Beta) |
| pytest | 테스트 | >=8.0 |
| Pylance | VSCode LSP (안정적) | - |

## 프로젝트 구조

```
project-name/
├── pyproject.toml
├── uv.lock
├── .python-version
├── .venv/
├── README.md
├── src/
│   └── project_name/
│       ├── __init__.py
│       └── py.typed
└── tests/
    └── test_example.py
```

## 초기화 명령어

```bash
# 라이브러리 프로젝트
uv init --lib project-name
cd project-name

# 개발 도구 추가
uv add --dev ruff ty pytest

# 실행
uv run python -m project_name
uv run pytest
uv run ruff check .
uv run ty check
```

## pyproject.toml 템플릿

```toml
[project]
name = "project-name"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = []

[dependency-groups]
dev = [
    "ruff>=0.14",
    "ty>=0.0.7",
    "pytest>=8.0",
]

# ===== Ruff =====
[tool.ruff]
line-length = 88
target-version = "py311"
exclude = [".venv", "venv", "__pycache__", "build", "dist"]

[tool.ruff.lint]
select = ["E", "F", "B", "I", "UP", "SIM", "ASYNC", "RUF"]
ignore = ["E501", "B008"]
fixable = ["ALL"]

[tool.ruff.lint.isort]
known-first-party = ["project_name"]

[tool.ruff.lint.per-file-ignores]
"tests/*" = ["B011"]
"__init__.py" = ["F401"]

[tool.ruff.format]
quote-style = "double"
docstring-code-format = true

# ===== ty =====
[tool.ty]
# ty는 requires-python 자동 감지

[tool.ty.src]
exclude = ["tests/fixtures/**"]
```

## VSCode settings.json (프로젝트용)

`.vscode/settings.json` 생성:

```jsonc
{
    // Python + Ruff
    "python.analysis.typeCheckingMode": "basic",
    "python.analysis.autoImportCompletions": true,
    "[python]": {
        "editor.defaultFormatter": "charliermarsh.ruff",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.fixAll.ruff": "explicit",
            "source.organizeImports.ruff": "explicit"
        }
    },
    // 파일 제외
    "files.exclude": {
        "**/__pycache__": true,
        "**/.pytest_cache": true,
        "**/.ruff_cache": true
    }
}
```

필수 Extensions: `ms-python.python`, `ms-python.vscode-pylance`, `charliermarsh.ruff`

## 코드 철학

### 핵심 원칙

1. **Explicit over Clever** - Type hints 필수, 명확한 네이밍
2. **Fail-Fast** - 예외 명시적 발생, 에러 숨기지 않음
3. **Self-Documenting** - 주석은 "왜(Why)"만
4. **Design First** - 설계 후 코딩
5. **Proven over Trendy** - 검증된 도구 우선

### 네이밍 (PEP 8)

- 변수/함수: `snake_case`
- 클래스: `PascalCase`
- 상수: `SCREAMING_SNAKE_CASE`
- Boolean: `is_`, `has_`, `can_` 접두사

### 함수/모듈 크기

- 함수: 20-50줄 목표, 100줄 초과 시 리팩토링
- 모듈: 200-400줄, 500줄 초과 시 분리

### 테스트

- 커버리지: 70-80% 목표
- 핵심 비즈니스 로직: 90% 이상
- Arrange-Act-Assert 패턴 사용

## 워크플로우 체크리스트

프로젝트 생성 시:

- [ ] `uv init --lib` 실행
- [ ] `uv add --dev ruff ty pytest` 실행
- [ ] pyproject.toml에 도구 설정 추가
- [ ] .vscode/settings.json 생성
- [ ] src/ 레이아웃 확인
- [ ] py.typed 파일 존재 확인

코드 작성 시:

- [ ] Type hints 작성
- [ ] 함수 20-50줄 유지
- [ ] 저장 시 자동 포맷팅 확인

커밋 전:

- [ ] `uv run ruff check --fix .`
- [ ] `uv run ruff format .`
- [ ] `uv run ty check`
- [ ] `uv run pytest`
