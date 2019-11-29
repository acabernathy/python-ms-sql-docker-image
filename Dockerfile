FROM ubuntu:18.04 AS base

LABEL \
    vendor="Adam C. Abernathy, LLC" \
    vendor.email="hello@adamabernathy.com" \
    version="1.1.0" \
    description="One stop shop for Python and MS SQL Server interface"

WORKDIR /app

RUN \
    # Clean up source code
    rm -fr /app/venv ; \
    # Install system packages
    apt-get update && apt-get install -y \
        curl \
        apt-transport-https \
        debconf-utils \
        gcc \
        g++ \
        python3-pip \
        python3-dev \
        python-dev \
        unixodbc-dev \
        locales ; \
    # Add custom Microsoft repository, and install MS ODBC Drivers
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - ; \
    curl https://packages.microsoft.com/config/ubuntu/19.04/prod.list > \
        /etc/apt/sources.list.d/mssql-release.list ; \
    apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools ; \
    locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 ; \
    # Clean up install files
    rm -rf /var/lib/apt/lists/* ;