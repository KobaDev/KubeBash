Notes:
    - Host: Ubuntu or Debian based
    - Kubernetes config files: Must be stored inside a folder named "manifests", stored in the root of the project, else, the files' path must be changed in the loop.

Necessary environment variables:
    - AWS_REGION
    - CLUSTER_NAME
    - MICROSERVICE_NAME
    - ENVIRONMENT
    - PROJECT_NAME

Microservice naming structure (can be changed):
    PROJECT_NAME-MICROSERVICE_NAME-ENVIRONMENT