#!/bin/bash
# sync-to-claude-code.sh
# Claude Code 스킬 디렉토리에 심볼릭 링크 생성

set -e

# 스크립트 위치 기준으로 저장소 경로 설정
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_REPO="$(dirname "$SCRIPT_DIR")"
CLAUDE_CODE_SKILLS="$HOME/.claude/skills"

echo "📦 Leo's Claude Skills Sync"
echo "================================"
echo "Source: $SKILLS_REPO"
echo "Target: $CLAUDE_CODE_SKILLS"
echo ""

# Claude Code 스킬 디렉토리 생성
mkdir -p "$CLAUDE_CODE_SKILLS"

# 각 스킬 폴더를 심볼릭 링크로 연결
for skill_dir in "$SKILLS_REPO"/*/; do
    skill_name=$(basename "$skill_dir")
    
    # scripts, .git 등 제외
    if [[ "$skill_name" == "scripts" ]] || [[ "$skill_name" == .* ]]; then
        continue
    fi
    
    # SKILL.md가 있는 폴더만 처리
    if [[ -f "$skill_dir/SKILL.md" ]]; then
        target_link="$CLAUDE_CODE_SKILLS/$skill_name"
        
        # 기존 링크/폴더 제거
        if [[ -L "$target_link" ]] || [[ -d "$target_link" ]]; then
            rm -rf "$target_link"
        fi
        
        # 심볼릭 링크 생성
        ln -s "$skill_dir" "$target_link"
        echo "✅ Linked: $skill_name"
    fi
done

echo ""
echo "================================"
echo "🎉 Sync complete!"
echo ""
echo "Linked skills:"
ls -la "$CLAUDE_CODE_SKILLS" | grep "^l"
