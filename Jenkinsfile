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
                sh 'curl https://github.com/jgm/pandoc/releases/download/2.1.3/pandoc-2.1.3-linux.tar.gz -o pandoc.tar.gz'
                sh 'echo "54d90c4cd710af5ebe3aa82aee6cb3bf1b7dbb06 pandoc.tar.gz" | sha1sum -c'
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
