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
                sh 'wget https://github.com/jgm/pandoc/releases/download/2.1.3/pandoc-2.1.3-linux.tar.gz -O pandoc.tar.gz'
                sh 'echo "abc6482c7ce216d2360e10efd201138f3b37d6da pandoc.tar.gz" | sha1sum -c'
                sh 'tar xf pandoc.tar.gz'
                sh 'PATH=pandoc-2.1.3/bin:"$PATH"./build-websites.sh'
            }
        }

        stage('Archive artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/website.tar.gz', onlyIfSuccessful: true
            }
        }
    }
}
