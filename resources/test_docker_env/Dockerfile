FROM python:3.8.2

COPY ./main.py ./main.py

ARG TEST_ONE
ENV TEST_ONE ${TEST_ONE}

ARG TEST_TWO
ENV TEST_TWO ${TEST_TWO}

ARG TEST_THREE
ENV TEST_THREE ${TEST_THREE}

ENTRYPOINT ["python", "main.py"]
