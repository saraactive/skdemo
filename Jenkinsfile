//To TRIGGER EMAIL
pipeline {
    agent any
     
    stages {
        stage('Ok') {
            steps {
                echo "Ok"
            }
        }
    }
    post {
        always {
            mail bcc: '', body: '''Project : UNIVERSAL DWS
Name=<YOUR NAME>

NOTE: Remove "?Please" in SUBJECT to APPROVED.
''', cc: '', from: 'ksakashkumar@gmail.com', replyTo: 'ksakashkumar@gmail.com', subject: '?PleaseAPPROVED', to: 'sarharih@in.ibm.com'
        }
    }
}
