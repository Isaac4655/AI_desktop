#!/bin/bash
# AXIOM Desktop Agent — Codespaces Setup Script
# Runs automatically after the container is created

set -e
echo "=== AXIOM: Installing Python dependencies ==="

pip install --break-system-packages --quiet \
  pyautogui \
  pillow \
  mss \
  pynput \
  openai \
  flask \
  fastapi \
  uvicorn \
  pydantic \
  loguru \
  python-dotenv \
  requests \
  opencv-python-headless \
  numpy

echo "=== AXIOM: Creating project folder structure ==="

for i in 1 2 3 4 5 6 7; do
  mkdir -p team$i
  # Create a stub README for each team
  if [ ! -f "team$i/README.md" ]; then
    echo "# Team $i Module" > team$i/README.md
    echo "Place your module code here." >> team$i/README.md
  fi
done

mkdir -p mocks output sample_screenshots

echo "=== AXIOM: Creating mock output files ==="

# Team 1 mock: screen description
cat > mocks/mock_screen_description.json << 'EOF'
{
  "timestamp": "2025-01-01T12:00:00Z",
  "resolution": "1280x800",
  "description": "Linux desktop with Fluxbox window manager. Taskbar visible at bottom. Desktop shows icons for Firefox, Terminal, and Files. No windows currently open.",
  "elements_visible": ["desktop icons", "taskbar", "clock showing 12:00"]
}
EOF

# Team 2 mock: UI elements
cat > mocks/mock_elements.json << 'EOF'
{
  "timestamp": "2025-01-01T12:00:00Z",
  "elements": [
    {"label": "Firefox icon", "x": 64, "y": 400, "type": "icon", "confidence": 0.95},
    {"label": "Terminal icon", "x": 64, "y": 450, "type": "icon", "confidence": 0.92},
    {"label": "Files icon", "x": 64, "y": 500, "type": "icon", "confidence": 0.91},
    {"label": "Taskbar", "x": 640, "y": 790, "type": "bar", "confidence": 1.0}
  ]
}
EOF

# Team 4 mock: action plan
cat > mocks/mock_action_plan.json << 'EOF'
{
  "goal": "open Firefox",
  "step": 1,
  "action": "double_click",
  "target": "Firefox icon",
  "target_x": 64,
  "target_y": 400,
  "reason": "Firefox icon is visible on the desktop. Double-clicking it will launch the browser.",
  "is_complete": false
}
EOF

# Team 5 mock: context
cat > mocks/mock_context.json << 'EOF'
{
  "current_goal": "open Firefox and search for weather",
  "step_count": 0,
  "action_history": [],
  "screen_history": [],
  "summary": "Task just started. No actions taken yet."
}
EOF

echo ""
echo "================================================"
echo " AXIOM Desktop Agent — Environment Ready!"
echo "================================================"
echo ""
echo " Browser Desktop: Check the PORTS tab and open port 6080"
echo " Password: vscode"
echo ""
echo " To run code on the noVNC desktop, set DISPLAY first:"
echo "   export DISPLAY=:1"
echo ""
echo " Then run your team's test scripts:"
echo "   python team1/your_script.py"
echo ""
