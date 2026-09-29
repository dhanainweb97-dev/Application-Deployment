pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Image') {
            steps {
                script {
                    def branch = env.GIT_BRANCH?.replaceFirst(/^origin\//, '')

                    if (branch == 'dev') {
                        env.DOCKER_IMAGE = 'dhanainweb97/dev:latest'
                    } else if (branch == 'master') {
                        env.DOCKER_IMAGE = 'dhanainweb97/prod:latest'
                    } else {
                        error "Unsupported branch: ${branch}"
                    }

                    echo "Branch: ${branch}"
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
