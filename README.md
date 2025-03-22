# open-webui_secure

[![GitHub last commit](https://img.shields.io/github/last-commit/NotYuSheng/open-webui_secure?color=red)](#)

An effort to remove all critical and high CVE vulnerabilities from the popular LLM web interface [open-webui](https://github.com/open-webui/open-webui).

This repository runs a trivy scan workflow everytime it is updated and every midnight UTC. Results of the scan is automatically updated in the [Latest Security Scan Results](#latest-security-scan-results) section. 

> [!NOTE]
> GitHub `Security` tab categorizes severity based on SARIF `level` (e.g., `"error"` = High, `"warning"` = Medium), which may differ from Trivy’s native severity field.

<!-- TRIVY_SCAN_RESULTS -->
## Latest Security Scan Results

🕒 **Last Scan (UTC):** 22 Mar 2025 12:40:03 AM UTC  
🕒 **Last Scan (SGT):** 22 Mar 2025 08:40:03 AM SGT  
🚨 **Critical Vulnerabilities:** 0  
⚠️ **High Vulnerabilities:** 0  
<!-- TRIVY_SCAN_END -->

## Base Image:
`ghcr.io/open-webui/open-webui:git-e6ff416-cuda`  
**Image Release Date:** 4th March 2025

## Prerequisites
- **Docker**
- **Docker Compose**
- **Trivy**

## Setup

1. **Installation**

   Clone the repository and navigate into the project directory:
   ```bash
   git clone https://github.com/NotYuSheng/open-webui_secure.git
   cd open-webui_secure
   ```
2. **Environment Setup**

   Add you llm server reference into `docker-compose.yml`. Alternatively, this can be later configured using the GUI.
   ```
   OPENAI_API_BASE_URL=
   OPENAI_API_KEY=
   ```
3. **Deploy the Service**

    Start the service using docker-compose:
   ```bash
   docker-compose up -d
   ```
4. **Enter the Running Container**

   Open a shell session inside the container:
   ```bash
   docker exec -it open-webui_secure sh
   ```
5. **Fix Vulnerabilities**

   Within the container, apply the necessary fixes (for example, by uninstalling or patching vulnerable components).

   Test that core functionalities such as Access Control, Admin Login, User Login, RAG, Admin Panel, Agentic Tools, and Native Tool Calling work as expected.

6. **Commit Your Changes**

   Once everything is verified, commit your container’s state with a new tag (replace `vX.X` with your version number):
   ```bash
   docker commit open-webui_secure open-webui_secure:vX.X
   ```
7. **Scan the Image with Trivy**

   Before pushing your image, run a vulnerability scan to ensure there are no critical or high CVEs:
   ```bash
   sudo trivy image --timeout 120m open-webui_secure:vX.X > trivy-analysis.txt
   ```
   Review the `trivy-analysis.txt` file and address any issues found. The process should fail or require fixes if critical vulnerabilities remain.

8. **Tag the Image for GHCR**

   Once your image is secure, tag it with your GitHub Container Registry namespace:
   ```bash
   docker tag open-webui_secure:vX.X ghcr.io/notyusheng/open-webui_secure:vX.X
   docker tag open-webui_secure:vX.X ghcr.io/notyusheng/open-webui_secure:latest
   ```
9. **Push the Image to GHCR**

   Log in to GHCR using your GitHub username and a Personal Access Token (PAT) with the write:packages scope:
   ```bash
   docker login ghcr.io -u <your-github-username>
   ```
   Then push both tagged images:
   ```bash
   docker push ghcr.io/notyusheng/open-webui_secure:vX.X
   docker push ghcr.io/notyusheng/open-webui_secure:latest
   ```

## Core Functionalities Under Active Testing
The following functionalities will be continuously tested and maintained:
- ~~Access Control~~
  - ~~Admin Login~~
  - ~~User Login~~
- Chat
- RAG
- Agentic Tools
- Native Tool Calling
