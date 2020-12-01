pipeline {
    agent any
    tools {
      maven 'maven3'
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn --version'
            }
        }
        stage('Upload War To Nexus'){
          steps{
            nexusArtifactUploader artifacts: [
              [
                artifactId: 'modresorts10war', 
                classifier: '', 
                file: 'target/modresorts-1.0.war', 
                type: 'war'
              ]
            ], 
            credentialsId: 'nexus3', 
            groupId: 'com.ibm.ta', 
            nexusUrl: '172.21.138.24:8081', 
            nexusVersion: 'nexus3', 
            protocol: 'http', 
            repository: 'http://nexus3-jake-cicd.paul-pg-roks-3cd0ec11030dfa215f262137faf739f1-0000.eu-gb.containers.appdomain.cloud/repository/webapp-release/', 
            version: '1.0.0'
          }
        }
    }
}