pipeline {
    agent {
        docker {
            image 'ruby'
            args '--network rocklov-network'

        }
    }

    stages {
        stage ('Prep'){
            steps {
                sh 'bundle install'
            }
        }
        stage('Testing') {
            steps {
                sh 'rspec'
            }
        }
    }
}
