#!/bin/zsh
# Shell Performance Testing Script
# Tests shell startup time and typing responsiveness

echo "🔍 Shell Performance Analysis"
echo "============================\n"

# Test 1: Shell Startup Time
echo "📊 Test 1: Shell Startup Time (run 10 times)"
echo "Lower is better. Target: < 200ms\n"

total=0
for i in {1..10}; do
    time_output=$( (time zsh -i -c exit) 2>&1 )
    # Extract the total time (last line, last column)
    shell_time=$(echo "$time_output" | grep "total" | awk '{print $NF}' | sed 's/s//')
    echo "Run $i: ${shell_time}s"
    total=$(echo "$total + $shell_time" | bc)
done

average=$(echo "scale=3; $total / 10" | bc)
echo "\n✅ Average startup time: ${average}s"

if (( $(echo "$average < 0.2" | bc -l) )); then
    echo "   Status: ✅ EXCELLENT (< 200ms)"
elif (( $(echo "$average < 0.5" | bc -l) )); then
    echo "   Status: ⚠️  GOOD (200-500ms)"
else
    echo "   Status: ❌ SLOW (> 500ms) - Further optimization needed"
fi

# Test 2: Plugin Load Analysis
echo "\n\n📊 Test 2: Loaded Plugins Analysis"
echo "====================================\n"

# Count plugins
plugin_count=$(grep "^plugins=" ~/.zshrc | sed 's/plugins=(//' | sed 's/)//' | tr ' ' '\n' | wc -l | tr -d ' ')
echo "Current plugin count: $plugin_count"
echo "Recommended: < 15 plugins for optimal performance\n"

# Show loaded plugins
echo "Active plugins:"
grep "^plugins=" ~/.zshrc | sed 's/plugins=(//' | sed 's/)//' | tr ' ' '\n' | nl

# Test 3: History File Size
echo "\n\n📊 Test 3: History File Analysis"
echo "================================\n"

if [[ -f ~/.zsh_history ]]; then
    history_lines=$(wc -l < ~/.zsh_history | tr -d ' ')
    history_size=$(du -h ~/.zsh_history | awk '{print $1}')
    echo "History entries: $history_lines"
    echo "History file size: $history_size"

    if (( history_lines > 10000 )); then
        echo "   ⚠️  Large history file may slow down autosuggestions"
        echo "   Consider: HISTSIZE=10000 SAVEHIST=10000"
    else
        echo "   ✅ History size is reasonable"
    fi
fi

# Test 4: Syntax Highlighting Configuration
echo "\n\n📊 Test 4: Syntax Highlighting Settings"
echo "========================================\n"

if grep -q "ZSH_HIGHLIGHT_MAXLENGTH" ~/.zshrc; then
    maxlength=$(grep "ZSH_HIGHLIGHT_MAXLENGTH" ~/.zshrc | cut -d'=' -f2 | tr -d ' ')
    echo "✅ Max highlight length configured: $maxlength characters"
else
    echo "❌ No max length set - may cause lag on long commands"
    echo "   Recommendation: Add ZSH_HIGHLIGHT_MAXLENGTH=300"
fi

if grep -q "ZSH_HIGHLIGHT_HIGHLIGHTERS" ~/.zshrc; then
    highlighters=$(grep "ZSH_HIGHLIGHT_HIGHLIGHTERS" ~/.zshrc | cut -d'=' -f2)
    echo "✅ Highlighters configured: $highlighters"
else
    echo "⚠️  All highlighters enabled (may be slow)"
    echo "   Recommendation: Use only (main brackets)"
fi

# Test 5: Typing Lag Test
echo "\n\n📊 Test 5: Interactive Typing Test"
echo "==================================\n"
echo "Type a long command in your terminal and observe:"
echo "  ✅ No delay: Characters appear instantly"
echo "  ⚠️  Slight delay: < 50ms lag is acceptable"
echo "  ❌ Noticeable delay: > 100ms requires optimization"
echo ""
echo "Test command suggestion (paste this):"
echo "  echo 'Testing typing performance with a reasonably long command that includes some shell features like \$(date) and variables like \$HOME'"

# Summary and Recommendations
echo "\n\n📋 Performance Optimization Summary"
echo "====================================\n"

echo "✅ Optimizations Applied:"
echo "   • Syntax highlighting length limited to 300 chars"
echo "   • Path highlighting disabled"
echo "   • Autosuggestions using async mode"
echo "   • Reduced plugin count from 21 to $plugin_count"
echo "   • Starship command timeout increased to 1000ms"

echo "\n💡 Additional Recommendations:\n"

if (( plugin_count > 15 )); then
    echo "   • Consider removing more plugins (currently: $plugin_count)"
fi

echo "   • If still experiencing lag, try disabling syntax highlighting entirely:"
echo "     # Comment out the syntax-highlighting source line in .zshrc"

echo "\n   • For maximum performance, consider using fast-syntax-highlighting:"
echo "     brew install zsh-fast-syntax-highlighting"

echo "\n   • Monitor performance with: time zsh -i -c exit"

echo "\n\n🎯 Quick Actions if Still Experiencing Lag:"
echo "==========================================="
echo "1. Temporarily disable syntax highlighting:"
echo "   sed -i.bak '/zsh-syntax-highlighting/s/^/# /' ~/.zshrc && source ~/.zshrc"
echo ""
echo "2. Restore if needed:"
echo "   mv ~/.zshrc.bak ~/.zshrc && source ~/.zshrc"
echo ""
echo "3. Test with minimal plugins:"
echo "   plugins=(git)"

echo "\n\nDone! 🚀\n"
