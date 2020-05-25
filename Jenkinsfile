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
        container(name: 'linter') {
          sh 'apt-get update && apt-get install -y tidy && cd sample-app && tidy -q -e *.html'
        }

      }
    }

    stage('Docker Build') {
      steps {
        container(name: 'docker') {
          sh "cd sample-app && docker build -t ${REGISTRY}:$GIT_COMMIT ."
        }

      }
    }

    stage('Docker push') {
      steps {
        container(name: 'docker') {
          withCredentials([usernamePassword(credentialsId: "${REGISTRY_CREDENTIAL}", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
           sh "docker login -u $USERNAME -p $PASSWORD && docker push ${REGISTRY}:$GIT_COMMIT"
          }

        }

      }
    }

    // stage('Docker Publish') {
    //   steps {
    //     container(name: 'docker') {
    //       withDockerRegistry(credentialsId: "${REGISTRY_CREDENTIAL}", url: 'https://registry-1.docker.io/v2/') {
    //         sh "docker push ${REGISTRY}:$GIT_COMMIT"
    //       }

    //     }

    //   }
    // }

    stage('Kubernetes Deploy') {
      steps {
        container(name: 'kubectl') {
          sh "sed -e s|${REGISTRY}|${REGISTRY}:$GIT_COMMIT|g sample-app/deploy-manifest.yaml | kubectl apply -f -"
        }

      }
    }

  }
  environment {
    REGISTRY = 'wideblue/udacity-microservice'
    REGISTRY_CREDENTIAL = 'dockerhub-wideblue'
  }
}