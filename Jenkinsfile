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
                go mod init example.com/m
                go get github.com/gruntwork-io/terratest/modules/terraform
                go get github.com/stretchr/testify/assert
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
            }
        }
        stage('Apply'){
            steps{
                echo "Applying terraform plan... "
                sh """
                terraform apply -input=false -var -auto-approve tag_bucket_name=terratest-s3-pipeline -var tag_bucket_environment=Training -var tag_owner=arajkumar@presidio.com -lock=false
                """
            }
        }
    }
}