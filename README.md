# LLM-Enabled NPC in Godot Game Engine

## Overview
This project integrates an LLM-powered NPC system into a Godot-based game. It includes:
- A pre-built exported game under `Exported Game/`
- A Colab-friendly notebook under `Python API Script/google_notebook_capstone.ipynb` that serves a Flask API backed by an LLM
- Guidance for secure key management

## Requirements
- Godot game (exported binaries are included in `Exported Game/`)
- Python 3.10+ for running the API if running locally
- Internet access for model downloads
- For the notebook: a GPU-backed runtime (e.g., Google Colab GPU or a GPU VM)
- An ngrok account with a reserved static domain (required)

## Important: Run the Notebook on a GPU Instance
- The notebook `Python API Script/google_notebook_capstone.ipynb` should be run on a GPU-enabled instance (e.g., Colab Runtime → Change runtime type → Hardware accelerator: GPU). CPU instances will be too slow or may fail to load larger models.

## Secure Key and Token Management
Never hardcode secrets in source files or notebooks. This repo reads tokens from environment variables.

- Hugging Face token (for the exact model used)
  - Model used: `Gigax/NPC-LLM-7B` (`https://huggingface.co/Gigax/NPC-LLM-7B`)
  - If access is gated, click “Access repository” or accept the license/terms on the model page.
  - Create a Read token (Settings → Access Tokens) and ensure your account has access to this model.
  - Environment variable: `HF_TOKEN`
  - Colab: Add a secret named `HF_TOKEN` via the left sidebar → Secrets.
  - Local: Create a `.env` file in the project root with a line like `HF_TOKEN=your_hf_token`.

- ngrok (required, for a public URL)
  - You must reserve a static domain (Dashboard → Domains → Reserved Domains → “+ Reserve Domain”), e.g., `your-name.ngrok-free.app`.
  - Environment variables (all required except region default): `NGROK_AUTHTOKEN`, `NGROK_DOMAIN`, `NGROK_REGION` (default `us`).
  - Colab: Add these as secrets in the sidebar.
  - Local: Add them to `.env`.

The notebook automatically reads these values from environment variables. Do not commit `.env` files to version control.

## Step-by-Step Setup

### 1) Get a Hugging Face Token for the Model
1. Go to the model page: `https://huggingface.co/Gigax/NPC-LLM-7B`.
2. If prompted, click “Access repository” or accept the model’s license/terms to enable access for your account.
3. In a separate tab, create a Read token: `https://huggingface.co/settings/tokens` → “New token” → role: Read.
4. Copy the token and set it as `HF_TOKEN`:
   - Colab: Left sidebar → Secrets → Add secret → Name: `HF_TOKEN`, Value: your token.
   - Local: Create `.env` in the repo root:
     ```env
     HF_TOKEN=hf_xxx_your_token_here
     ```

### 2) Set Up ngrok and Reserve a Static Public Domain (Required)
1. Sign up at `https://dashboard.ngrok.com/signup` (or sign in).
2. Copy your Authtoken (Dashboard → Your Authtoken).
3. Reserve a domain (Dashboard → Domains → Reserved Domains → “+ Reserve Domain”), e.g., `your-name.ngrok-free.app`.
4. Configure your environment (all required):
   - Colab Secrets: add `NGROK_AUTHTOKEN`, `NGROK_DOMAIN` (your reserved domain), `NGROK_REGION` (e.g., `us`).
   - Local `.env`:
     ```env
     NGROK_AUTHTOKEN=your_ngrok_authtoken
     NGROK_REGION=us
     NGROK_DOMAIN=your-name.ngrok-free.app
     ```

### 3) Update the Game’s API URL in Godot
1. Open `Game_project_files/temp/Label.gd`.
2. Replace the existing line with your reserved domain:
   ```gdscript
   var url = 'https://your-name.ngrok-free.app/AcchaProject'
   ```
3. Save the file.

### 4) Update the Notebook Configuration
- The notebook requires `HF_TOKEN`, `NGROK_AUTHTOKEN`, `NGROK_REGION`, and `NGROK_DOMAIN` to be set (via Colab Secrets or `.env`).
- The final test cell posts to `https://$NGROK_DOMAIN/AcchaProject`. Ensure `NGROK_DOMAIN` is set to your reserved domain.

## Run Order (API First, Then Game)
1. Open and run `Python API Script/google_notebook_capstone.ipynb` in a GPU runtime (Colab recommended).
   - Wait for: `Public URL: NgrokTunnel: "https://your-name.ngrok-free.app" -> "http://localhost:5001"`.
2. Verify you can POST to the API (the notebook’s last cell uses `NGROK_DOMAIN`, or use curl):
   ```bash
   curl -X POST https://your-name.ngrok-free.app/AcchaProject \
     -H "Content-Type: application/json" \
     -d '{"input":"Hello","character":1}'
   ```
3. Launch the exported game from `Exported Game/`.
4. In-game, press the **M** key to interact with the NPC.

## Development Notes
- Uses `transformers`, `gigax`, and optional `bitsandbytes` for 8-bit loading.
- If you see authentication warnings for Hugging Face Hub, ensure `HF_TOKEN` is present and your account has access to `Gigax/NPC-LLM-7B`.
- For local runs, a sample `.env`:
  ```env
  HF_TOKEN=your_hf_token
  NGROK_AUTHTOKEN=your_ngrok_token
  NGROK_REGION=us
  NGROK_DOMAIN=your-name.ngrok-free.app
  ```

## Security Hygiene Checklist
- [x] No tokens hardcoded in the notebook
- [x] README documents secret handling, GPU requirement, and run order
- [x] `.env` is used locally and not committed

## License
MIT License

Copyright (c) 2025 Tanishq216

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
