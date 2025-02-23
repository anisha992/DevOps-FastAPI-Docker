# FastAPI Docker CI/CD with GitHub Actions

## Objective
This project demonstrates Continuous Delivery by automating the creation and deployment of a Dockerized FastAPI application using GitHub Actions.

## Project Structure
```
|-- main.py                   # FastAPI server
|-- requirements.txt          # Dependencies
|-- Dockerfile                # Docker image setup
|-- .github/
    |-- workflows/
        |-- DockerBuild.yml   # GitHub Actions workflow
```

## Prerequisites
- Python installed
- Docker installed
- GitHub account
- Docker Hub account
- GitHub repository with Actions enabled

---

## 1. Setting Up FastAPI Server

Create a Python script (`main.py`) for the FastAPI server:
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Hello, FastAPI!"}
```

Define dependencies in `requirements.txt`:
```
fastapi
uvicorn
```
Install dependencies:
```
pip install -r requirements.txt
```
Run the server locally:
```
uvicorn main:app --host 0.0.0.0 --port 8000
```

---

## 2. Containerizing the Application

Create a `Dockerfile` to build the FastAPI application:
```dockerfile
FROM ubuntu:latest
RUN apt update && apt install -y python3 python3-pip
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

Build and run the Docker image locally:
```
docker build -t my-fastapi-app .
docker run -p 8000:8000 my-fastapi-app
```

---

## 3. Automating with GitHub Actions

Create a GitHub Actions workflow in `.github/workflows/DockerBuild.yml`:
```yaml
name: Docker Image Build

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Build & Push Image
        run: |
          echo "${{ secrets.DOCKERTOKEN }}" | docker login -u "<your-dockerhub-username>" --password-stdin
          docker build -t <your-dockerhub-username>/<image-name>:latest .
          docker push <your-dockerhub-username>/<image-name>:latest
```

### Setting Up Docker Token and Secrets
1. Generate a token from Docker Hub:
   - Go to [Docker Hub](https://hub.docker.com/)
   - Account Settings → Security → Access Tokens → Generate Token
2. Add it as a secret in GitHub:
   - Go to `https://github.com/<your-username>/<repo>/settings/secrets/actions/new`
   - Name it `DOCKERTOKEN`

---

## 4. Requirements
- **GitHub Repository URL** (containing: `main.py`, `requirements.txt`, `Dockerfile`, `.github/workflows/DockerBuild.yml`, `README.md`)
- **Docker Hub Image URL** (where the image is pushed)

---

## References
- [Dockerize FastAPI Guide]([https://hub.docker.com/](https://upessocs.github.io/#dir=/Lectures/DevOps%20CCVT/Unit%202/&file=023%20Dockerize%20python%20fastapi%20server%20with%20github%20actions%20and%20upload%20to%20docker%20registery.md))

