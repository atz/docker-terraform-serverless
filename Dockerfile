FROM hashicorp/terraform:0.12.12
LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Serverless with Terraform for CI/CD"

RUN apk add --update git bash openssh make nodejs nodejs-npm
RUN npm install -g \
    serverless@1.66.0 \
    serverless-plugin-git-variables \
    serverless-terraform-outputs \
    serverless-domain-manager
# Note: ignore "serverless update check failed" warning during "npm install"

# Heavyweight considering we only use awscli for configuration, presently.
RUN apk add --update python py-pip             && \
    pip install --upgrade awscli python-gitlab && \
    apk --purge del py-pip                     && \
    rm /var/cache/apk/*

ENTRYPOINT ["/bin/bash", "-l", "-c"]
