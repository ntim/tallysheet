#!/usr/bin/python
import websocket
import thread
import time


def on_message(ws, message):
    print message


def on_error(ws, error):
    print error


if __name__ == "__main__":
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("ws://localhost:3000/websocket",
                                on_message=on_message,
                                on_error=on_error)
    ws.run_forever()
