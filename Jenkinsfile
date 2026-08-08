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
    }

    post {
        always {
            sh 'docker rm -f ticket-backend-test 2>/dev/null || true'
        }

        success {
            echo 'CI pipeline completed successfully!'
        }

        failure {
            echo 'CI pipeline failed!'
        }
    }
}
