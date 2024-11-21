# Kubebash

These scripts are dedicated for use with Kubernetes. Some functionalities are bound to AWS services, but most utilise Kubectl, which is a Kubernetes tool that isn't restricted to a provider. These scripts were written for purposes of troubleshooting and automation. Further scripts might be developed in the future.

This repository also includes a deploy template with already placed environment variables. This script can be integrated into a pipeline, using a host executing Ubuntu or a Debian-based Linux distribution. For further information, check the 'config.txt' file, which contains necessary environment variables for the script to work.

For the collection of multiple services' logs instead of ones from individual services, you must include the namespaces in the 'services.txt' file, **segregated by a newline character.** This is especially useful when the log collection of multiple services is recurrent.