FROM golang AS builder
WORKDIR /go
RUN go get -u github.com/cloudflare/cfssl/cmd/...

FROM fedora:latest
COPY --from=builder /go/bin/* /usr/bin/
RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.2.10.tar.gz \
    && tar xzvf openshift-client-linux-4.2.10.tar.gz \
    && mv ./oc ./kubectl /usr/bin/
RUN yum install -y openssl httpd-tools jq gettext
RUN mkdir /work
COPY . /work/
