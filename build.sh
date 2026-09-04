#!/bin/bash
# Re-embeds wheel.png and wheel_frame.png as base64 data URIs directly in index.html.
# Run this after replacing either PNG so the shipped single-file page stays in sync.
cd "$(dirname "$0")"

python3 -c "
import base64, re

with open('wheel.png', 'rb') as f:
    b64_wheel = base64.b64encode(f.read()).decode()
with open('wheel_frame.png', 'rb') as f:
    b64_frame = base64.b64encode(f.read()).decode()

with open('index.html', 'r') as f:
    html = f.read()

html = re.sub(
    r'(<img id=\"wheel\" src=\")(?:data:image/png;base64,[^\"]+|wheel\.png)(\")',
    lambda m: m.group(1) + 'data:image/png;base64,' + b64_wheel + m.group(2),
    html,
)
html = re.sub(
    r'(<img id=\"frame\" src=\")(?:data:image/png;base64,[^\"]+|wheel_frame\.png)(\")',
    lambda m: m.group(1) + 'data:image/png;base64,' + b64_frame + m.group(2),
    html,
)

with open('index.html', 'w') as f:
    f.write(html)
"

echo "Re-embedded wheel.png and wheel_frame.png into index.html"
