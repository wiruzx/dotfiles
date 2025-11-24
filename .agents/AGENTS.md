# Workflow

Goal is to be autonomous.

VERY IMPORTANT: The only way to verify work of an agent is if it's committed to repository.
Please commit each change separately with a simple message with a tag:

Example for claude code:
git commit -m '[claude] fixed UI issues on playing screen'

Example of lables for other agent systems:
OpenAI Codex - [codex]
Google Gemini - [gemini]
Cursor - [cursor]

Don't try to build the app without committing the changes. Commit often

When undoing past work, prefer reverting commits, never git do reset

Please ignore all the files in the following directories. Never change them, never use them.
./SpeechifyPodcasts/
