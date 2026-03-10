# System Discovery Report
*Generated: 2026-03-09 22:55:59 UTC*
*Scan Type: Comprehensive Asset Discovery*

## Executive Summary
Automated discovery scan to identify unknown systems and close inventory gaps.

---

## Google Cloud Platform Assets

⚠️ gcloud CLI not installed or configured
## GitHub Repositories

⚠️ GITHUB_TOKEN not set - skipping GitHub discovery
## Container Infrastructure

⚠️ Docker not installed
## Kubernetes Resources

⚠️ kubectl not installed
## Local Services & Applications

### Listening Ports
```
COMMAND     PID        USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
ControlCe 38887 rsannicolas    9u  IPv4 0xd75b09257d4185c4      0t0  TCP *:7000 (LISTEN)
ControlCe 38887 rsannicolas   10u  IPv6 0x6e7754c195a379dd      0t0  TCP *:7000 (LISTEN)
ControlCe 38887 rsannicolas   11u  IPv4 0xb2db19ed3b60797d      0t0  TCP *:5000 (LISTEN)
ControlCe 38887 rsannicolas   12u  IPv6 0xb52b977e39797f07      0t0  TCP *:5000 (LISTEN)
rapportd  38922 rsannicolas   10u  IPv4 0x181c0cda06ab8ae0      0t0  TCP *:61115 (LISTEN)
rapportd  38922 rsannicolas   11u  IPv6 0xfbfd8a4c2267d00a      0t0  TCP *:61115 (LISTEN)
logioptio 39173 rsannicolas   43u  IPv4 0xd8a61c1abc7f0063      0t0  TCP *:59869 (LISTEN)
Spotify   39200 rsannicolas   69u  IPv4 0x68e83d4b4b1c65d5      0t0  TCP 127.0.0.1:7768 (LISTEN)
Spotify   39200 rsannicolas   72u  IPv4 0xcd1b42d716c527f4      0t0  TCP *:61217 (LISTEN)
Spotify   39200 rsannicolas  106u  IPv4 0x17e77b2f5fea02ba      0t0  TCP *:57621 (LISTEN)
Adobe\x20 39306 rsannicolas   34u  IPv4 0xe77437e82598c746      0t0  TCP 127.0.0.1:15292 (LISTEN)
Adobe\x20 39306 rsannicolas   46u  IPv4 0x672a1cb642cc9acc      0t0  TCP 127.0.0.1:15393 (LISTEN)
Adobe\x20 39306 rsannicolas   50u  IPv4 0xec924ae73fb97071      0t0  TCP 127.0.0.1:16494 (LISTEN)
LogiPlugi 39383 rsannicolas  296u  IPv4  0x5eca834670bfe05      0t0  TCP 127.0.0.1:59317 (LISTEN)
LogiPlugi 39383 rsannicolas  317u  IPv4 0x3f7522bdde86462f      0t0  TCP 127.0.0.1:59320 (LISTEN)
LogiPlugi 39383 rsannicolas  352u  IPv4 0x9e857a9754e3c730      0t0  TCP 127.0.0.1:59326 (LISTEN)
Creative  39502 rsannicolas   20u  IPv4 0x99b2f7b322a5a35d      0t0  TCP 127.0.0.1:59400 (LISTEN)
Creative  39502 rsannicolas   21u  IPv4 0xb5984f1e59081296      0t0  TCP 127.0.0.1:59401 (LISTEN)
Creative  39502 rsannicolas   22u  IPv4 0xa0b28f9d132d8b44      0t0  TCP 127.0.0.1:45623 (LISTEN)
```

## Infrastructure as Code

### Terraform Files Found
```
No Terraform files found
```

## Environment Configuration

### Configured Services (from environment)
```
No service endpoints in environment
```

## Application Dependencies

## Discovery Statistics

### Summary Counts
- GCP Resources: ~0
0 active
- GitHub Repositories: ~0
0 found
- Docker Containers:        0
0 running
- Discovery Timestamp: 2026-03-09 22:56:14 UTC

## Risk Assessment

### Discovered Risks


### Recommended Actions
1. Document all discovered systems in asset registry
2. Review public-facing services for security
3. Validate ownership of discovered resources
4. Tag cloud resources with appropriate metadata
5. Schedule deep-dive assessment for critical findings

