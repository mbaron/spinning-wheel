#!/bin/bash
# Builds a self-contained HTML file with both images embedded as base64
cd "$(dirname "$0")"

python3 -c "
import base64

with open('wheel.png', 'rb') as f:
    b64_wheel = base64.b64encode(f.read()).decode()
with open('wheel_frame.png', 'rb') as f:
    b64_frame = base64.b64encode(f.read()).decode()

with open('friday-spinning-wheel.html', 'r') as f:
    html = f.read()

html = html.replace('src=\"wheel.png\"', f'src=\"data:image/png;base64,{b64_wheel}\"')
html = html.replace('src=\"wheel_frame.png\"', f'src=\"data:image/png;base64,{b64_frame}\"')

with open('friday-spinning-wheel-standalone.html', 'w') as f:
    f.write(html)
"

echo "Created friday-spinning-wheel-standalone.html"
