pipeline {
    agent any
    tools {
        terraform 'terraform'
        go 'gotool'
    }
    environment {
        GO117MODULE = 'on'
    }
    stages{
        stage('Initialize'){
            steps{
                echo "Initializing terraform... "
                sh 'terraform init -upgrade=false'
            }
        }
        stage('Terratest'){
            steps{
                sh """
                go test
                """
            }
        }
        stage('Plan'){
            steps{
                echo "Making terraform plan... "
                sh """
                terraform plan -input=false -var tag_bucket_name=terratest-s3-pipeline -var tag_bucket_environment=Training -var tag_owner=arajkumar@presidio.com -lock=false
                """
                script{
                       env.RELEASE = input message: 'Should we apply the plan ?', ok: 'Continue',
                             parameters: [booleanParam(name: 'APPLY')] 
                }
            }
        }
        stage('Apply'){
            when {
                 expression{
                     return env.RELEASE
                 }
            }
            steps{
                echo "Applying terraform plan... "
                sh """
                terraform apply -input=false -auto-approve -var tag_bucket_name=terratest-s3-pipeline -var tag_bucket_environment=Training -var tag_owner=arajkumar@presidio.com -lock=false
                """
            }
        }
    }
}