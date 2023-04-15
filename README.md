<h1>Temporary repository to test a bug fix on the Kong plugin rate-limiting</h1>

This is a guide on how to test the bug fix in [PR 10559](https://github.com/Kong/kong/pull/10559)

To simulate the bug, it is necessary to run parallel requests:
 - Versions of the Kong plugin rate-limiting below Kong version 3.2.2 have a race condition that compromises accuracy.
 - The version on the PR mentioned above fixes this race condition.

## Testing

### Requires
* make
* docker
* docker-compose


### Running tests

```bash
make run # This runs redis, Kong version 3.2.2, and a Kong with a fixed version of the rate-limiting plugin.
make test # This runs a test on Kong version 3.2.2. According to the plugin configuration shown in the kong.yaml file, only 1 request should return status 200, but the test shows that more than 1 request can access the target.
make test-fixed # This test shows that only 1 request returns 200 even under parallel calls, respecting the plugin configuration.
make stop # Stop containers

```
### This is an example of a failed test running command make test

```bash
     iterations.....................: 20     500.600533/s
   ✗ Status200......................: 7      175.210187/s
   ✗ Status429......................: 13     325.390346/s


running (00m00.0s), 00/20 VUs, 20 complete and 0 interrupted iterations
default ✓ [ 100% ] 20 VUs  00m00.0s/10m0s  20/20 shared iters
time="2023-04-15T05:48:35Z" level=error msg="thresholds on metrics 'Status200, Status429' have been breached"
make: *** [test] Error 99
```

### This is an example of a successful test running command make test-fixed

```bash
     iterations.....................: 20     998.784729/s
   ✓ Status200......................: 1      49.939236/s
   ✓ Status429......................: 19     948.845492/s


running (00m00.0s), 00/20 VUs, 20 complete and 0 interrupted iterations
default ✓ [ 100% ] 20 VUs  00m00.0s/10m0s  20/20 shared iters
Test finished
```