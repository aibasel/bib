# Installing dependencies

Create a [virtual environment](https://docs.python.org/3/tutorial/venv.html),
activate it and install all dependencies:

    sudo apt install python3 python3-venv
    python3 -m venv --prompt myvenv .venv
    source .venv/bin/activate
    pip install --upgrade pip wheel
    pip install -r requirements.txt


# Running tests

Activate the virtual environment with

    source .venv/bin/activate

Then run the tests with

    ./run-tests.sh
