pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh '''
                    cd backend
                    python -m unittest discover -s tests -v
                '''
            }
        }

        stage('Build Backend') {
            steps {
                sh 'docker build -t ticket-backend:latest ./backend'
            }
        }

        stage('Build Frontend') {
            steps {
                sh 'docker build -t ticket-frontend:latest ./frontend'
            }
        }
    }

    post {
        success {
            echo 'CI pipeline completed successfully!'
        }

        failure {
            echo 'CI pipeline failed!'
        }
    }
}
