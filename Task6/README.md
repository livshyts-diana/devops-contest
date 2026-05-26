### 1. Встановлення Jenkins у Docker-контейнері

- **Опис:** Головний сервер оркестрації Jenkins Master був розгорнутий в окремому Docker-контейнері `jenkins-master` на базі офіційного LTS-образу Jenkins. Для забезпечення взаємодії між контейнерами створено окрему Docker-мережу `jenkins_network`.

- **Команда запуску:**

```bash
docker run -d \
  --name jenkins-master \
  --network jenkins_network \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```

---

### 2. Встановлення необхідних плагінів

- **Опис:** Під час початкової конфігурації Jenkins було встановлено стандартний набір рекомендованих плагінів (*Suggested Plugins*), що включає:
  - Git Plugin
  - Pipeline Plugin
  - Credentials Binding Plugin
  - GitHub Integration Plugin

Встановлені модулі забезпечили підтримку CI/CD-процесів, інтеграцію з GitHub та роботу декларативних Pipeline.

---

### 3. Налаштування build-агентів у Docker-контейнерах

- **Опис:** У Jenkins створено дві окремі build-ноди:
  - `agent-1`
  - `agent-2`

Агенти були розгорнуті у Docker-контейнерах на базі образу `jenkins/inbound-agent:alpine`. Для надання доступу до Docker Engine хост-системи всередину контейнерів змонтовано системний Docker Socket `/var/run/docker.sock`.

- **Команди запуску агентів:**

```bash
docker run -d \
  --name jenkins-agent-1 \
  --network jenkins_network \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --user root \
  jenkins/inbound-agent:alpine \
  -url http://jenkins-master:8080 \
  f7911e0ab6f25cb892b8631a1ff0f2a654842dcb5df26a2890b681f595197b0f \
  agent-1
```

```bash
docker run -d \
  --name jenkins-agent-2 \
  --network jenkins_network \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --user root \
  jenkins/inbound-agent:alpine \
  -url http://jenkins-master:8080 \
  539acb6810941b7b150472637792413f9126cf03dc9e877cd1ca0411af7c4e78 \
  agent-2
```

---

### 4. Створення Freestyle-проєкту для виведення поточної дати

- **Опис:** Створено Freestyle Job `date-freestyle`, у якому в секції **Build Steps** додано shell-команду `date`. Під час запуску Job у консоль Jenkins виводиться поточна дата та час системи.

- **Команда:**

```bash
date
```

- **Результат виконання:**

```text
Finished: SUCCESS
```

---

### 5. Створення Pipeline для виконання `docker ps -a`


- **Опис:** Було реалізовано Pipeline `docker-ps-pipeline`, який запускається на build-агенті з доступом до Docker Socket. Усередині Alpine-контейнера автоматично встановлюється Docker CLI через `apk`, після чого виконується команда перегляду всіх контейнерів хост-системи.

- **Pipeline Script:**

```groovy
pipeline {
    agent any

    stages {
        stage('Docker PS') {
            steps {
                sh '''
                    apk add --no-cache docker-cli
                    docker ps -a
                '''
            }
        }
    }
}
```

---

### 6. Створення Pipeline для збірки Docker-образу з GitHub

- **Опис:** Розгорнуто Pipeline `github-docker-build`, який автоматично:
  1. Очищає workspace Jenkins
  2. Клонує репозиторій із GitHub
  3. Виконує збірку Docker-образу на основі Dockerfile із директорії `Task4`

- **Pipeline Script:**

```groovy
pipeline {
    agent any

    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Clone Repository') {
            steps {
                git 'https://github.com/USERNAME/REPOSITORY.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-contest-image ./Task4'
            }
        }
    }
}
```

---

### 7. Передача зашифрованої змінної `PASSWORD=QWERTY!`


- **Опис:** Секретне значення було додано до Jenkins Credentials Manager як об’єкт типу `Secret text` із ID `my-secret-password`.

Під час виконання Pipeline Jenkins автоматично приховує значення секрету в логах консолі, що запобігає витоку конфіденційної інформації.

- **Pipeline Script:**

```groovy
pipeline {
    agent any

    environment {
        PASSWORD = credentials('my-secret-password')
    }

    stages {
        stage('Show Secret') {
            steps {
                sh 'echo PASSWORD=$PASSWORD'
            }
        }
    }
}
```

---

# EXTRA-завдання


### 2. Створення Ansible Playbook для автоматичного розгортання Jenkins

- **Статус:** Виконано
- **Опис:** Створено Infrastructure as Code Playbook `deploy-jenkins.yml`, який автоматизує:
  - оновлення пакетів системи
  - встановлення Docker
  - створення Docker-мережі
  - запуск Jenkins Master

- **Приклад Playbook:**

```yaml
- name: Deploy Jenkins
  hosts: all
  become: true

  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present

    - name: Create Docker Network
      command: docker network create jenkins_network

    - name: Run Jenkins Container
      command: >
        docker run -d
        --name jenkins-master
        --network jenkins_network
        -p 8080:8080
        -p 50000:50000
        -v jenkins_home:/var/jenkins_home
        jenkins/jenkins:lts
```

---

### 3. Розгортання локального Docker Registry

- **Опис:** Було розгорнуто локальний приватний Docker Registry на порту `5000`. Після цього продемонстровано повний цикл роботи з образом:
  - створення тегу
  - push у registry
  - pull із registry

- **Команди:**

```bash
docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name local-registry \
  registry:2
```

```bash
docker tag devops-contest-image:latest \
  localhost:5000/devops-contest-image:latest
```

```bash
docker push localhost:5000/devops-contest-image:latest
```

```bash
docker pull localhost:5000/devops-contest-image:latest
```

---
