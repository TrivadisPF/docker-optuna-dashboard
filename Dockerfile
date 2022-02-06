FROM conda/miniconda3:latest
LABEL maintainer="Guido Schmutz <guido.schmutz@trivadis.com>"

WORKDIR /optuna/

ARG OPTUNA_DASHBOARD_VERSION=0.5.0
RUN mkdir -p /optuna/ \
  && apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    default-libmysqlclient-dev \
    libpq-dev \
  && pip install \
    optuna-dashboard==$OPTUNA_DASHBOARD_VERSION \
    sqlalchemy \
    psycopg2 \
    mysqlclient

EXPOSE 8080

CMD optuna-dashboard sqlite:///db.sqlite3 \
  --port 8080 \
  --host 0.0.0.0