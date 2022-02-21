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
                exec(open('Startcoffee.py').read())
            if (message == "!makeCoffeonTime"):
                try:
                    async for date in websocket:
                        print("[RECIVED]" + date)
                        try:
                            async for time in websocket:
                                print("[RECIVED]" + time)
                                print (message, date, time)                            
                                exec(open('Startcoffee.py').read())
                                await websocket.send("!FINISHED")
                        except websockets.exceptions.ConnectionClosed as e:
                            print("[CONNECTION CLOSED]")
                except websockets.exceptions.ConnectionClosed as e:
                    print("[CONNECTION CLOSED]")
    except websockets.exceptions.ConnectionClosed as e:
        print("[CONNECTION CLOSED]")

start_server = websockets.serve(handling_client, "192.168.2.118", PORT)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()