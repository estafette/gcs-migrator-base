FROM python:3.11

ENV PYINSTALLER_CONFIG_DIR=/root/.pyconfig

RUN set -eux && \
    apt-get update; \
    apt-get install --no-install-recommends -y \
        python3-dev build-essential patchelf upx; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    python -m pip install --no-cache-dir --upgrade --force --ignore-installed pip; \
    python -m pip install --no-cache-dir --upgrade wheel SCons; \
    python -m pip install --no-cache-dir --upgrade staticx pyinstaller

RUN mkdir -p /root/.pyconfig
RUN git clone -b features/migration-api-TL-129 https://github.com/estafette/estafette-ci-api.git
WORKDIR /estafette-ci-api/gcs-migrator
RUN pip install -r requirements.txt
RUN pyinstaller --strip -F -n gcs-migrator server.py
RUN mkdir -p ../publish
RUN staticx --strip dist/gcs-migrator ../publish/gcs-migrator
RUN rm -rf /estafette-ci-api
