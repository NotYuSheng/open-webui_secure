# open-webui_secure

[![GitHub last commit](https://img.shields.io/github/last-commit/NotYuSheng/open-webui_secure?color=red)](#)

An effort to remove all critical and high CVE vulnerabilities from the popular LLM web interface [open-webui](https://github.com/open-webui/open-webui).

This repository runs a trivy scan workflow everytime it is updated and every midnight UTC. Results of the scan is automatically updated in the [Latest Security Scan Results](#latest-security-scan-results) section. 

> [!NOTE]
> GitHub `Security` tab categorizes severity based on SARIF `level` (e.g., `"error"` = High, `"warning"` = Medium), which may differ from Trivy’s native severity field.

<!-- TRIVY_SCAN_RESULTS -->
## Latest Security Scan Results

🕒 **Last Scan (UTC):** 08 May 2025 12:44:32 AM UTC  
🕒 **Last Scan (SGT):** 08 May 2025 08:44:32 AM SGT  
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

## End-User Deployment
For end users who want to deploy the secure version of the application, we provide a dedicated Docker Compose file with the necessary configurations named to `docker-compose.secure.yml`.

1. **Download the Secure Compose File**:

   Only the `docker-compose.secure.yml` is necessary, all other files in the repository is intended for CVE remediation.

2. **Deploy the Secure App**:

   To launch the secure app using Docker Compose, run:
   ```bash
   docker compose -f docker-compose.secure.yml up -d
   ```
   Alternatively, you can rename the `docker-compose.secure.yml` file to `docker-compose.yml` and run normally:
   ```bash
   mv docker-compose.secure.yml docker-compose.yml
   docker compose up -d
   ```

3. **Verify Deployment**

   Once the containers are running, you can verify that the secure application is up and running by visiting the corresponding ports (e.g., `http://localhost:8080`).

## CVE Remediation Contribution Guide

1. **Fork and Clone the Repository**

   Fork: On GitHub, navigate to `https://github.com/NotYuSheng/open-webui_secure.git` and click the "Fork" button to create a copy under your own account.

   Clone:
   ```bash
   git clone https://github.com/<your-github-username>/open-webui_secure.git
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
   Test that core functionalities listed in [Core Functionalities Under Active Testing](#core-functionalities-under-active-testing) section work as expected.

5. **Commit Your Changes Locally**

   Commit your container’s state with a new tag (replace `vX.X.X` with your version number):
   ```bash
   docker commit open-webui_secure open-webui_secure:vX.X.X
   ```
6. **Scan the Image with Trivy**

   Before pushing your image, run a vulnerability scan to ensure there are no critical or high CVEs:
   ```bash
   sudo trivy image --timeout 120m --severity CRITICAL,HIGH open-webui_secure:vX.X.X > trivy-analysis.txt
   ```
   Review the `trivy-analysis.txt` file and address any issues found. The process should fail or require fixes if critical vulnerabilities remain.

7. **Push Your Changes and Submit a Pull Request**

   Once your image is secure, tag it with your GitHub Container Registry namespace:
   ```bash
   git push origin main
   ```
   Open a pull request on GitHub from your forked repository to the original repository (`NotYuSheng/open-webui_secure`), detailing your fixes and improvements.
   Include the trivy-analysis.txt file as an attachment or add its contents to the PR description.

## Core Functionalities Under Active Testing
The following functionalities will be continuously tested and maintained:
- Access Control
  - Admin Login
  - User Login
- Chat
- RAG
- Agentic Tools
- Native Tool Calling
- Arena Mode
