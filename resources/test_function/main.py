import os


def handle(request):
    """
    """
    return {
        "status": "OK",
        "description": "Test Function",
        "details": f"ONE: {os.getenv('ONE')}, TWO: {os.getenv('TWO')}"
    }
