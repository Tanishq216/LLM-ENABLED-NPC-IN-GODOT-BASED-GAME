 # Contributing

Thank you for helping improve this project. This document describes the preferred workflows, development setup, and security practices for contributing.

## Quick links
- Project overview and setup: [README.md](README.md)  
- Notebook API server: [Python API Script/google_notebook_capstone.ipynb](Python API Script/google_notebook_capstone.ipynb) (see the `BulawaAgaya` handler)  
- In-game API client (update URL): [Game_project_files/temp/Label.gd](Game_project_files/temp/Label.gd)  
- Player script stub: [Game_project_files/Scripts/player.gd](Game_project_files/Scripts/player.gd)  
- Exported binaries for manual testing: [Exported Game/](Exported Game/)  
- Python dependencies: [requirements.txt](requirements.txt)  
- License: [LICENSE](LICENSE)

## Code of conduct
Be respectful and constructive. Filing issues and proposing changes should focus on measurable improvements.

## Reporting issues
- Prefer GitHub issues for bugs and feature requests.
- Provide: steps to reproduce, expected vs actual behavior, logs/screenshots, and platform details.
- If the issue involves the notebook API, reference the notebook cell or function (e.g., `BulawaAgaya` in [google_notebook_capstone.ipynb](Python API Script/google_notebook_capstone.ipynb)).

## Local development setup
1. Create a virtual environment and install deps:
   ```sh
   python -m venv .venv
   source .venv/bin/activate  # or .venv\Scripts\activate on Windows
   pip install -r requirements.txt