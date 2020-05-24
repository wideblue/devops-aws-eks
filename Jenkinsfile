pipeline {
    environment {
        REGISTRY = 'wideblue/udacity-microservice'
        REGISTRY_CREDENTIAL = 'dockerhub-wideblue'
    }
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            yamlFile 'build.yaml'
        }
    }
    stages {
        stage('Lint') {
            steps {
                container('Linter') {
                    sh 'cd sample-microservice && make lint'
                }
            }
        }
        stage('Docker Build') {
            steps {
                container('docker') {
                    sh "cd sample-microservice && docker build -t ${REGISTRY}:$GIT_COMMIT ."
                }
            }
        }
        stage('Docker Publish') {
            steps {
                container('docker') {
                    withDockerRegistry([credentialsId: "${REGISTRY_CREDENTIAL}", url: ""]) {
                        sh "docker push ${REGISTRY}:$GIT_COMMIT"
                    }
                }
            }
        }
        stage('Kubernetes Deploy') {
            steps {
                container('kubectl') {
                    sh "kubectl run  udacity-app --image=${REGISTRY}:$GIT_COMMIT --port 80 --restart Never"
                }
            }
        }
    }
}