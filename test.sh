if [ -z "$1" ]
  then 
    echo "Missing arguments: access_key"
    echo "test.sh <access_key> <secret_key>"
    exit 0
fi

if [ -z "$2" ]
  then
    echo "Missing arguments: secret_key"
    echo "test.sh <access_key> <secret_key>"
    exit 0
fi
#That is for terratest
export TF_VAR_access_key=$1
export TF_VAR_secret_key=$2
export AWS_ACCESS_KEY_ID=${TF_VAR_access_key}
export AWS_SECRET_ACCESS_KEY=${TF_VAR_secret_key}

#Creating a tfvars
cd aws
echo "" > terraform.tfvars
echo "access_key=\"${TF_VAR_access_key}\"" >> terraform.tfvars
echo "secret_key=\"${TF_VAR_secret_key}\"" >> terraform.tfvars
cd ..
#Test moment
cd test
go test -v