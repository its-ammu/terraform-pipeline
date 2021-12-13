package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsS3Example(t *testing.T) {
	t.Parallel()
	expectedName := "terratest-s3-pipeline"
	expectedEnvironment := "Training"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: ".",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"tag_bucket_name":        expectedName,
			"tag_bucket_environment": expectedEnvironment,
			"tag_owner":              "arajkumar@presidio.com",
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	bucket_name := terraform.Output(t, terraformOptions, "bucket_name")

	assert.Equal(t, expectedName, bucket_name)

}
