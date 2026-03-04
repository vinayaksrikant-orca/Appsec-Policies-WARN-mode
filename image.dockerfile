# 1. OUTDATED BASE IMAGE (Scanner: OS Vulnerability / CVE)
# This version of Alpine (3.10) is from 2019 and has hundreds of known vulnerabilities.
# A modern scanner will flag this immediately.
FROM alpine:3.10

# Set a working directory
WORKDIR /app

# 2. VULNERABLE APPLICATION LIBRARY (Scanner: SCA / Language Vulnerability)
# We are installing an old version of the 'requests' Python library (2.20.0).
# This version has multiple CVEs, including CVE-2018-18074 (Redirect to HTTPS).
RUN apk add --no-cache python3 py3-pip && \
    pip3 install requests==2.20.0

# Copy a dummy application file (optional)
COPY app.py .

# 3. HARDCODED SECRET (Scanner: Secret Detection)
# Many image scanners also look for secrets accidentally left in environment variables.
# This "fake" API key pattern will trigger a "High" severity alert.
ENV API_KEY="AIzaSyAExampleSecretKey4ScanTestingOnly"

# Set a dummy command to keep the container running
CMD ["python3", "-c", "print('Vulnerable image is running...')"]