pipeline {
    agent any
    stages {
        stage('Update submodules') {
            steps {
                sh 'git submodule update --init --remote'
            }
        }

        stage('Build websites') {
            steps {
                sh '[ -e "pandoc.deb" ] || curl -L https://github.com/jgm/pandoc/releases/download/1.17.2/pandoc-1.17.2-1-amd64.deb -o pandoc.deb'
                sh 'echo "84fe35ed9be0f1d8eb6d4cc03d63a8e532e9776f pandoc.deb" | sha1sum -c'
                sh 'dpkg -x pandoc.deb pandoc'
                sh 'PATH="$(pwd)/pandoc/usr/bin":"$PATH" bash -x ./build-websites.sh'
            }
        }

        stage('Archive artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/website.tar.gz', onlyIfSuccessful: true
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
