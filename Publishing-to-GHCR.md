# Publishing to GHCR (Admin Use)

These can only be done for collaborators with write access to this repository. Contact repo owner `NotYuSheng` to request for collaborator access.

1. **Clone the Repository**
   ```bash
   git clone https://github.com/notyusheng/open-webui_secure.git
   cd open-webui_secure
   ```
2. **Environment Setup**

   Add you llm server reference into `docker-compose.yml`.
   ```
   OPENAI_API_BASE_URL=
   OPENAI_API_KEY=
   ```
   This can be later configured using the GUI.

3. **Fix Vulnerabilities**

   Modify the `Dockerfile` (or other relevant files) to upgrade or remove vulnerable packages and apply necessary security patches.

4. **Deploy and Test**

   Start the service using docker-compose:
   ```bash
   docker compose up -d
   ```
   Test that core functionalities listed in [Core Functionalities Under Active Testing](#Core-Functionalities-Under-Active-Testing) section work as expected.

5. **Commit Your Changes Locally**

   Commit your container’s state with a new tag (replace `vX.X.X` with your version number):
   ```bash
   docker commit open-webui_secure open-webui_secure:vX.X.X
   ```
6. **Scan the Image with Trivy**

   Before pushing your image, run a vulnerability scan to ensure there are no critical or high CVEs:
   ```bash
   sudo trivy image --timeout 120m --severity CRITICAL,HIGH --format json open-webui_secure:vX.X.X > trivy-analysis.json
   ```
   Review the `trivy-analysis.txt` file and address any issues found. The process should fail or require fixes if critical vulnerabilities remain.

7. **Tag the Image for GHCR**

   Once your image is secure, tag it with your GitHub Container Registry namespace:
   ```bash
   docker tag open-webui_secure:vX.X.X ghcr.io/notyusheng/open-webui_secure:vX.X.X
   docker tag open-webui_secure:vX.X.X ghcr.io/notyusheng/open-webui_secure:latest
   ```
8. **Push the Image to GHCR**

   Log in to GHCR using your GitHub username and a Personal Access Token (PAT) with the write:packages scope:
   ```bash
   docker login ghcr.io -u <your-github-username>
   ```
   Then push both tagged images:
   ```bash
   docker push ghcr.io/notyusheng/open-webui_secure:vX.X.X
   docker push ghcr.io/notyusheng/open-webui_secure:latest
   ```
