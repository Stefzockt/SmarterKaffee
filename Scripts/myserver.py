import os
import websockets
import asyncio

PORT = 5050

print("[SERVER STARTING]")
print("[SERVER LISTENING ON ] " + str(PORT))

async def handling_client(websocket, path):
    print("[CONNECTION ESTABLISHED]")
    try:
        async for message in websocket:
            print("[RECIVED]" + message)
            if (message=="!makeCoffe"):
                os.system("Startcoffe.py")
            if (message == "!makeCoffeonTime"):
                os.system("TimeController.py")
            if (message == "!Disconnect"):
                break
            await websocket.send("Pong: " + message)
    except websockets.exceptions.ConnectionClosed as e:
        print("[CONNECTION CLOSED]")

start_server = websockets.serve(handling_client, "localhost", PORT)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()