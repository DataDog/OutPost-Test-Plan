1. `make cluster`
2. `make deploy`

3. `k logs -l app=falco`  and verify falco is logging rule checks
4. `k logs -l name=fluentbit` verify fluent-bit created the log group and stream processor started

5. Verify audit logs show up in cloudwatch logs

6. `make clean`
7. `make clean-cluster`



** For falco we use a slightly older kernel version AMI image for EKS v1.14

