import requests
import time

def call_api(url):
    try:
        response = requests.get(url, timeout=5)
        print(f"Response from {url}: {response.status_code} - {response.text}")
    except requests.exceptions.Timeout:
        print(f"Error calling {url}: Request timed out")
    except requests.exceptions.RequestException as e:
        print(f"Error calling {url}: {e}")

def main():
    url = "http://fruitflies-service:80"
    while True:
        call_api(url)
        time.sleep(1)

if __name__ == "__main__":
    main()