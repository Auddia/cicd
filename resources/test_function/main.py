import json
import logging


def handle(request):
    """
    """
    logging.info("Test log message")
    return {
        "status": "OK",
        "description": "Test Function"
    }
