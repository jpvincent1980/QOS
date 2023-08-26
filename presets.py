import os

from dotenv import load_dotenv

load_dotenv()

LOGIN = os.getenv("LOGIN")
PASSWORD = os.getenv("PASSWORD")
BASE_URL = os.getenv("BASE_URL")
