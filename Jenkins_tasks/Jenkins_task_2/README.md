# 🚀 Jenkins CI/CD Java Application

<div align="center">

### Production-Style CI/CD Pipeline for a Java Maven Application

**Jenkins • Maven • Java 11 • Docker • Docker Hub • Shared Libraries • GitHub**

<br>

![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-11-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-3.5.4-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Version%20Control-181717?style=for-the-badge&logo=github&logoColor=white)

<br>

![Pipeline](https://img.shields.io/badge/CI%2FCD-Automated-success?style=flat-square)
![Pipeline Type](https://img.shields.io/badge/Pipeline-Declarative%20%7C%20Scripted-blue?style=flat-square)
![Shared Library](https://img.shields.io/badge/Jenkins-Shared%20Library-orange?style=flat-square)
![Docker Hub](https://img.shields.io/badge/Docker%20Hub-Image%20Registry-2496ED?style=flat-square)

</div>

---

## 📌 Overview

This project demonstrates a complete Jenkins CI/CD pipeline for a Java Maven application.

The project implements both Declarative and Scripted Jenkins Pipelines, integrates a reusable Jenkins Shared Library, builds and tests the Java application, containerizes it using Docker, pushes the image to Docker Hub, and finally deploys the application as a Docker container.

---

## 🔄 CI/CD Workflow

```text
┌──────────────┐
│    GitHub    │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│   Checkout   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Maven Build  │
│   Java 11    │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Unit Tests  │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Docker Build │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Docker Login │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Docker Push  │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│    Deploy    │
│ Docker Run   │
└──────────────┘
```

---

## 🏗️ Project Structure

```text
Jenkins_task_2/
│
├── .github/
├── screenshots/
├── src/
│
├── Dockerfile
├── Jenkinsfile
├── Jenkinsfile-scripted
├── pom.xml
├── mvnw
├── mvnw.cmd
│
└── README.md
```

---

## 🔧 Jenkins Pipelines

### Declarative Pipeline

The `Jenkinsfile` implements the CI/CD workflow using Jenkins Declarative Pipeline syntax.

Main stages:

- Build Java App
- Test Java App
- Build Docker Image
- Push Docker Image to Docker Hub
- Deploy Docker Container

Jenkins tools are configured using:

```groovy
tools {
    jdk 'JDK11'
    maven 'maven3-5-4'
}
```

---

### Scripted Pipeline

The `Jenkinsfile-scripted` implements the same CI/CD workflow using Jenkins Scripted Pipeline syntax.

It uses Jenkins agents and explicit stages:

```groovy
node('node1') {
    stage('Build') {
        // Build application
    }
}
```

The Scripted Pipeline also demonstrates explicit source-code checkout using:

```groovy
checkout scm
```

---

## 📚 Jenkins Shared Library

The project uses a Jenkins Shared Library to provide reusable CI/CD logic.

The Shared Library contains reusable classes for:

- Maven commands
- Docker image building
- Docker Hub login
- Docker image pushing

Example Maven usage:

```groovy
def mvn = new edu.depi.maven()

mvn.mavenCommand("test")
```

Example Docker usage:

```groovy
def docker = new edu.depi.docker()

docker.dockerBuild(
    'a7medsayed/depi-java-app',
    "${BUILD_NUMBER}"
)
```

### 🔗 Shared Library Repository

[![Shared Library](https://img.shields.io/badge/GitHub-depi--sharedlib-181717?style=for-the-badge&logo=github)](https://github.com/ahmed-sayed-devops/depi-sharedlib)

https://github.com/ahmed-sayed-devops/depi-sharedlib

---

## 🐳 Docker

The Java application is packaged as a Docker image using the generated Maven JAR.

Docker image:

```text
a7medsayed/depi-java-app:<BUILD_NUMBER>
```

Each Jenkins build generates a unique Docker image tag using the Jenkins build number.

Example:

```text
a7medsayed/depi-java-app:15
```

---

## 🔐 Jenkins Credentials

Docker Hub credentials are securely stored in Jenkins Credentials.

The pipeline uses:

```groovy
withCredentials([
    usernamePassword(
        credentialsId: 'dockerhub-login',
        passwordVariable: 'DOCKER_PASSWD',
        usernameVariable: 'DOCKER_USERNAME'
    )
])
```

This keeps Docker Hub credentials outside the source code.

---

## 🚀 Deployment

After pushing the Docker image, Jenkins deploys the application as a Docker container.

Before deployment, the pipeline checks whether a container with the same name already exists.

If the container exists, it is removed:

```bash
docker rm -f depi-java-app
```

Then the new container is started:

```bash
docker run -d \
    --name depi-java-app \
    -p 8090:8090 \
    a7medsayed/depi-java-app:${BUILD_NUMBER}
```

This provides a simple automated replacement deployment strategy.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java 11 | Application Runtime |
| Spring Boot | Java Application Framework |
| Maven | Build & Dependency Management |
| Jenkins | CI/CD Automation |
| Declarative Pipeline | Pipeline as Code |
| Scripted Pipeline | Pipeline Automation |
| Jenkins Shared Library | Reusable Pipeline Logic |
| Docker | Containerization |
| Docker Hub | Container Registry |
| GitHub | Source Code Management |
| Linux | CI/CD Execution Environment |

---

## 🎯 Key Concepts Demonstrated

- Jenkins CI/CD
- Pipeline as Code
- Declarative Pipeline
- Scripted Pipeline
- Jenkins Agents
- Jenkins Tools
- Jenkins Credentials
- Jenkins Shared Libraries
- Maven Build
- Automated Testing
- Docker Image Build
- Docker Registry
- Docker Hub Authentication
- Automated Docker Deployment
- Build Number Image Tagging

---

## 👨‍💻 Author

**Ahmed Sayed**

DevOps & Multi-Cloud Engineer

- GitHub: https://github.com/ahmed-sayed-devops
- LinkedIn: https://www.linkedin.com/in/ahmed-sayed-devops

---

<div align="center">

### 🚀 Build • Test • Containerize • Push • Deploy

</div>