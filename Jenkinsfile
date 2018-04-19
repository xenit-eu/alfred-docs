pipeline {
    agent any
    stages {
        stage('Update submodules') {
            steps {
                sh 'git submodule update'
            }
        }

        stage('Build websites') {
            steps {
                sh './build-websites.sh'
            }
        }

        stage('Archive artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/website.tar.gz', onlyIfSuccessful: true
            }
        }
    }
}
