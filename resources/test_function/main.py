import json
import logging
import os


def handle(request):
    """
    """
    logging.info("Test log message")
    logging.info(f"ONE: {os.getenv('ONE')}, TWO: {os.getenv('TWO')}")
    return {
        "status": "OK",
        "description": "Test Function"
    }
