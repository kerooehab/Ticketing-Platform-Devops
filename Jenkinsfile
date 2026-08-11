pipeline {
    agent any

    stages {

        stage('Build Backend') {
            steps {
                sh 'docker build -t ticket-backend:ci ./backend'
            }
        }

        stage('Backend Smoke Test') {
            steps {
                sh '''
                    docker rm -f ticket-backend-test 2>/dev/null || true

                    docker run -d \
                        --name ticket-backend-test \
                        ticket-backend:ci

                    sleep 5

                    docker exec ticket-backend-test \
                        python -c "import urllib.request; r=urllib.request.urlopen('http://127.0.0.1:5000/health'); print(r.read().decode()); assert r.status == 200"

                    docker rm -f ticket-backend-test
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                sh 'docker build -t ticket-frontend:ci ./frontend'
            }
        }

        stage('Push Images') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_TOKEN'
                )]) {
                    sh '''
                        echo "$DOCKERHUB_TOKEN" | docker login \
                            -u "$DOCKERHUB_USER" \
                            --password-stdin docker.io

                        docker tag ticket-backend:ci \
                            docker.io/$DOCKERHUB_USER/ticket-backend:$BUILD_NUMBER

                        docker tag ticket-frontend:ci \
                            docker.io/$DOCKERHUB_USER/ticket-frontend:$BUILD_NUMBER

                        docker push \
                            docker.io/$DOCKERHUB_USER/ticket-backend:$BUILD_NUMBER

                        docker push \
                            docker.io/$DOCKERHUB_USER/ticket-frontend:$BUILD_NUMBER
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    helm upgrade --install ticketing ./helm/ticketing \
                        -n ticketing \
                        --set backend.image.tag=$BUILD_NUMBER \
                        --set frontend.image.tag=$BUILD_NUMBER

                    kubectl -n ticketing rollout status deployment/backend \
                        --timeout=120s

                    kubectl -n ticketing rollout status deployment/frontend \
                        --timeout=120s
                '''
            }
        }
    }

    post {
        always {
            sh 'docker rm -f ticket-backend-test 2>/dev/null || true'
        }

        success {
            echo 'CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'CI/CD pipeline failed!'
        }
    }
}
