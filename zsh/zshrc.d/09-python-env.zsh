

VIRTUAL_ENV="$HOME/.venv"
reinstall=0

if [ ! -d $VIRTUAL_ENV ]; then
    mkdir -p $VIRTUAL_ENV
    python3 -m venv $VIRTUAL_ENV
    reinstall=1
fi

if [ -d $VIRTUAL_ENV ]; then
    export VIRTUAL_ENV
    export PATH="$VIRTUAL_ENV/bin:$PATH"
fi

if [ $reinstall -eq 1 ]; then
    pip install --upgrade pip
    pip install --upgrade setuptools
    pip install --upgrade wheel
fi

