FROM gcr.io/cloud-builders/gcloud-slim@sha256:8eb8ff9c51b9a73ad54caa9f6b3f6cca0b254d0c3db1f4a78faec074fee36c5a as runtime # latest
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM runtime as test
RUN add-apt-repository ppa:duggan/bats \
    && apt-get update \
    && apt-get install -y bats
ADD test.bats /test.bats
ADD mock.sh /builder/google-cloud-sdk/bin/gcloud
RUN /test.bats

FROM runtime