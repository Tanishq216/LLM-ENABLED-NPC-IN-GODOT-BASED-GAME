# Learn

This file summarizes what to read and where to start learning this project.

## Quick start
- Read the main overview: [README.md](README.md).  
- Run the API first: open the notebook [Python API Script/google_notebook_capstone.ipynb](Python API Script/google_notebook_capstone.ipynb) and run its cells in a GPU runtime.
- Launch the game next: use the exported binaries in [Exported Game/](Exported Game/).

## Key files & symbols
- Notebook API server: [Python API Script/google_notebook_capstone.ipynb](Python API Script/google_notebook_capstone.ipynb) — primary handler: [`BulawaAgaya`](Python API Script/google_notebook_capstone.ipynb).  
- In-game HTTP client: [Game_project_files/temp/Label.gd](Game_project_files/temp/Label.gd) — sends requests via `var url` and [`send_post_request`](Game_project_files/temp/Label.gd) / [`_on_request_completed`](Game_project_files/temp/Label.gd).  
- Player script stub: [Game_project_files/Scripts/player.gd](Game_project_files/Scripts/player.gd).  
- Python dependencies: [requirements.txt](requirements.txt).  
- License: [LICENSE](LICENSE).  
- Asset license example: [Game_project_files/Assets/Rogue_City/License.txt](Game_project_files/Assets/Rogue_City/License.txt).

## How it works (high level)
1. The notebook initializes an LLM-backed Flask API and exposes a public URL via ngrok (see the notebook cell that prints the public URL). The notebook’s request handler (callable: [`BulawaAgaya`](Python API Script/google_notebook_capstone.ipynb)) accepts JSON with keys `input` and `character`.
2. The Godot game (runtime) posts player text to that URL. See [Game_project_files/temp/Label.gd](Game_project_files/temp/Label.gd) where `var url` is defined and used by [`send_post_request`](Game_project_files/temp/Label.gd).
3. The notebook returns a JSON response; the client callback [`_on_request_completed`](Game_project_files/temp/Label.gd) updates the game UI.

## Running locally (notebook)
1. Create and activate a Python venv:
   ```sh
   python -m venv .venv
   source .venv/bin/activate  # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```
2. Export environment variables (or use Colab secrets):
   ```env
   HF_TOKEN=your_hf_token
   NGROK_AUTHTOKEN=your_ngrok_token
   NGROK_REGION=us
   NGROK_DOMAIN=your-name.ngrok-free.app
   ```
   See setup details in [README.md](README.md).
3. Run the notebook cells (or extract the Flask app block) and wait for the printed ngrok public URL.

## Updating the game to hit your API
- Edit the URL in [Game_project_files/temp/Label.gd](Game_project_files/temp/Label.gd) (the `var url` line) to your reserved ngrok domain. See README instructions: [README.md](README.md).

## Debugging tips
- Notebook logs: check the notebook output cell streams — Flask logs appear in stderr (search for "Starting the Flask app" in the notebook). See the test POST example near the end of the notebook that posts to the API.  
- Godot logs: use print() statements in [Game_project_files/temp/Label.gd](Game_project_files/temp/Label.gd). The file already prints the outgoing JSON body and request errors.  
- Verify HTTP: curl the API endpoint manually:
  ```bash
  curl -X POST https://your-name.ngrok-free.app/AcchaProject \
    -H "Content-Type: application/json" \
    -d '{"input":"Hello","character":1}'
  ```
  (This mirrors the notebook example that posts a test request.)

## Extending NPCs and behavior
- NPC definitions and action logic are in [Python API Script/google_notebook_capstone.ipynb](Python API Script/google_notebook_capstone.ipynb). Edit the NPC sets and the `BulawaAgaya` handler to add or change NPC personalities, skills, and event handlers.

## Security & tokens
- Never hardcode tokens. Use environment variables or Colab secrets. See secure key guidance in [README.md](README.md) and contribution note in [CONTRIBUTING.md](CONTRIBUTING.md).

## Contributing & learning more
- See contribution workflow and development setup: [CONTRIBUTING.md](CONTRIBUTING.md).  
- For code changes: update source under `Game_project_files/` and re-export the build; avoid editing files under [Exported Game/](Exported Game/) except for QA.

## Useful references
- Notebook: [Python API Script/google_notebook_capstone.ipynb](Python API Script/google_notebook_capstone.ipynb) (`BulawaAgaya` handler).  
- Godot client: [Game_project_files/temp/Label.gd](Game_project_files/temp/Label.gd) (`var url`, `send_post_request`, `_on_request_completed`).  
- Project overview and setup: [README.md](README.md).  
- Contribution rules: [CONTRIBUTING.md](CONTRIBUTING.md).  
- Dependencies: [requirements.txt](requirements.txt).  
- License: [LICENSE](LICENSE).

Thank you — follow the README run-order (API first, then game) and consult the notebook logs when in doubt.