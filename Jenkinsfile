pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'dhanainweb97'
        DOCKER_IMAGE = 'dhanainweb97/prod:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Image') {
            steps {
                script {
                    echo "Production branch: master"
                    echo "Docker image: ${env.DOCKER_IMAGE}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh './build.sh "$DOCKER_IMAGE"'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DH_USERNAME',
                        passwordVariable: 'DH_PASSWORD'
                    )
                ]) {
                    sh '''
                        set -e
                        echo "$DH_PASSWORD" | docker login -u "$DH_USERNAME" --password-stdin
                        docker push "$DOCKER_IMAGE"
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'DOCKER_IMAGE="$DOCKER_IMAGE" ./deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Production application deployed successfully!'
        }
        failure {
            echo 'Production pipeline failed. Check the stage logs.'
        }
    }
}
```