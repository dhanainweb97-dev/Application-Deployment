pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'dhanainweb97'
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
                    if (env.BRANCH_NAME == 'dev') {
                        env.DOCKER_IMAGE = 'dhanainweb97/dev:latest'
                    } else if (env.BRANCH_NAME == 'master') {
                        env.DOCKER_IMAGE = 'dhanainweb97/prod:latest'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }

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
            echo 'Application deployed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the stage logs.'
        }
    }
}
