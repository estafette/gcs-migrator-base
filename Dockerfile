FROM python:3.12

RUN set -eux && \
    apt-get update; \
    apt-get install --no-install-recommends -y \
        python3-dev build-essential patchelf upx; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    python -m pip install --no-cache-dir --upgrade --force --ignore-installed pip; \
    python -m pip install --no-cache-dir --upgrade wheel SCons; \
    python -m pip install --no-cache-dir --upgrade staticx pyinstaller

COPY requirements.txt /tmp

RUN pip install -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt

