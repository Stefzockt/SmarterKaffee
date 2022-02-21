import websockets
import asyncio

PORT = 5050
IP_ADDRESS = "192.168.2.113"

print("[SERVER STARTING]")
print("[SERVER LISTENING ON ] " + str(PORT))

async def handling_client(websocket, path):
    print("[CONNECTION ESTABLISHED]")
    try:
        async for message in websocket:
            print("[RECIVED]" + message)
            message_split = message.split('\r\n',)
            if (message_split[0] =="!makeCoffe"):
                exec(open('C:\Projects\SmarterKaffee\Scripts\Startcoffee.py').read())
            if (message_split[0] == "!makeCoffeonTime"):
                exec(open(f'Startcoffee.py {message_split[1]} {message_split[2]}').read())
    except websockets.exceptions.ConnectionClosed as e:
        print("[CONNECTION CLOSED]")

start_server = websockets.serve(handling_client, IP_ADDRESS, PORT)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()