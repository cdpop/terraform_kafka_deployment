# Define the AWS credentials
aws_region="us-east-1"
aws_access_key_id=""
aws_secret_access_key=""

# Initialize SG 
key_pair_name=""
security_group_name=""

# Define EC2 setup
ami=""
type_instance=""
ec2_name=""

# Email for tagging instance to prevent auto deletion within 12 hours.
# XYZ@confluent.io
owner_email="Auto Delete Enabled"

# Define which script to run
shell_script_name="vincents_demo.sh"

