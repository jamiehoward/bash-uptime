# Simple Uptime Monitor

## Installation and usage

1. Create a list of urls to check by `cp sites.list.example sites.list`
2. Run the check by `sh ./monitor.sh`

## Continuous monitoring

If you'd like to run continuously, consider using the `watch` program. This can be installed using `brew install watch` and then running the following:

`watch -n 60 /path/to/project/monitor.sh`
