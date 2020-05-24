pipeline {
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yamlFile 'build.yaml'
    }

  }
  stages {
    stage('Lint') {
      steps {
        container(name: 'Linter') {
          sh 'cd sample-microservice && make lint'
        }

      }
    }

    stage('Docker Build') {
      steps {
        container(name: 'docker') {
          sh "cd sample-microservice && docker build -t ${REGISTRY}:$GIT_COMMIT ."
        }

      }
    }

    stage('Docker Publish') {
      steps {
        container(name: 'docker') {
          withDockerRegistry(credentialsId: "${REGISTRY_CREDENTIAL}", url: 'https://registry.hub.docker.com') {
            sh "docker push ${REGISTRY}:$GIT_COMMIT"
          }

        }

      }
    }

    stage('Kubernetes Deploy') {
      steps {
        container(name: 'kubectl') {
          sh "kubectl run  udacity-app --image=${REGISTRY}:$GIT_COMMIT --port 80 --restart Never"
        }

      }
    }

  }
  environment {
    REGISTRY = 'wideblue/udacity-microservice'
    REGISTRY_CREDENTIAL = 'dockerhub-wideblue'
  }
}