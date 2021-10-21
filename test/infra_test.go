package test

import (  
  "testing"

  "github.com/gruntwork-io/terratest/modules/aws"  
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

// Standard Go test, with the "Test" prefix and accepting the *testing.T struct.
func TestEC2S3Bucket(t *testing.T) {  

  // This is using the terraform package that has a sensible retry function.
  terraformOpts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    // Our Terraform code is in the root folder.
    TerraformDir: "../aws/",    
  })

  // We want to destroy the infrastructure after testing.
  defer terraform.Destroy(t, terraformOpts)

  // Deploy the infrastructure with the options defined above
  terraform.InitAndApply(t, terraformOpts)

  
  // Get the bucket ID so we can query AWS
  bucketID := terraform.Output(t, terraformOpts, "s3_id")
    
  bucketTags := aws.GetS3BucketTags(t, "us-east-1", bucketID)

  // Verify that Flugel tag is one of the tags
	nameS3Tag, containsS3NameTag := bucketTags["Name"]
	assert.True(t, containsS3NameTag)
	assert.Equal(t, "Flugel", nameS3Tag)

  // Verify that our InfraTeam tag is one of the tags  
	ownerS3Tag, containsS3OwnerTag := bucketTags["Owner"]
	assert.True(t, containsS3OwnerTag)
	assert.Equal(t, "InfraTeam", ownerS3Tag)

  // Get the EC2 Instance ID so we can query AWS
  instanceID := terraform.Output(t, terraformOpts, "instance_id")

  instanceTags := aws.GetTagsForEc2Instance(t, "us-east-1", instanceID)

  // Verify that Flugel tag is one of the tags
	nameTag, containsNameTag := instanceTags["Name"]
	assert.True(t, containsNameTag)
	assert.Equal(t, "Flugel", nameTag)

  // Verify that our InfraTeam tag is one of the tags  
	ownerTag, containsOwnerTag := instanceTags["Owner"]
	assert.True(t, containsOwnerTag)
	assert.Equal(t, "InfraTeam", ownerTag)
}