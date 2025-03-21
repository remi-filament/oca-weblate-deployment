FROM weblate/weblate:4.3.2-1

USER 0

RUN pip3 install "weblate-odoo-component-generator @ git+https://github.com/acsone/weblate-odoo-component-generator@988a69bc95c9a303a5e400c88acafba4d6a4e2fb"

# wocg-oca needs oca-maintainer-tools to enumerate addons repos and branches
RUN apt-get update && \
  apt-get install -y python3-venv && \
  python3 -m venv /opt/oca-maintainer-tools && \
  /opt/oca-maintainer-tools/bin/pip install -U pip wheel setuptools && \
  /opt/oca-maintainer-tools/bin/pip install git+https://github.com/OCA/maintainer-tools@72bb3f46a8a1f136f9033dbd9291cb294d5f53cd

COPY wocg-oca /usr/local/bin/

USER 1000

CMD ["runserver"]
