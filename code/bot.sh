echo "Enter build folder: "
read build_folder
mkdir $build_folder
cd $build_folder

mkdir modules
mkdir routers

echo "\nBuilding modules..."

python3 -m venv venv
source venv/bin/activate

# create run.sh
echo "source venv/bin/activate
python -X pycache_prefix=__pycache__ -m pip install -r requirements.txt > /dev/null
python -X pycache_prefix=__pycache__ main.py" > run.sh
chmod +x run.sh


# create env.json
echo '{
    "bot": {
        "token": "BOT_TOKEN",
        "url": "BOT_USERNAME"
    },
    "telegram": {
        "url": "https://t.me/"
    }
}' > env.json

# create requirements.txt
echo 'aiogram==2.25.1
aiohttp==3.8.3
aiosignal==1.3.1
async-timeout==4.0.2
attrs==22.2.0
Babel==2.9.1
certifi==2022.12.7
charset-normalizer==2.1.1
frozenlist==1.3.3
idna==3.4
magic-filter==1.0.9
multidict==6.0.4
pytz==2022.7.1
yarl==1.8.2' > requirements.txt

# create main.py
echo 'from modules.env import *
import routers\n\n
# Path: routers/start_command.py
Init.Bot.dp.register_message_handler(routers.start_command, commands="start")\n\n
Init.Bot.executor.start_polling(
    dispatcher=Init.Bot.dp, 
    skip_updates=False, 
    timeout=9**10,
    on_startup=print("Bot started!")
)' > main.py

# create modules/env.py
echo 'import json
envfile: str = json.load(fp=open("env.json", "r"))

class Config:

    class Telegra:
        url: str = envfile["telegram"]["url"] 

    class Bot:
        token: str = envfile["bot"]["token"]
        name: str = envfile["bot"]["url"] 
    
class Init:

    class Bot:
        from aiogram import Bot, Dispatcher, executor
        bot: Bot = Bot(token=Config.Bot.token)
        dp: Dispatcher = Dispatcher(bot)
        executor = executor' > modules/env.py

# create routers/__init__.py
echo 'from .start_command import *' > routers/__init__.py

# create routers/start_command.py
echo 'from aiogram import types

async def start_command(message: types.Message):
    await message.reply("Hello!")' > routers/start_command.py
