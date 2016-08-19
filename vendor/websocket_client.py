#!/usr/bin/python
import websocket
import subprocess
import time


def on_message(ws, message):
    print message
    # Create print command
    # subprocess.call("echo \"" + message + "\" | lp", shell=True)


def on_error(ws, error):
    print error


if __name__ == "__main__":
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("ws://localhost:3000/websocket",
                                on_message=on_message,
                                on_error=on_error)
    while True:
        ws.run_forever()
        # If connection is lost, we land here...
        time.sleep(1)
