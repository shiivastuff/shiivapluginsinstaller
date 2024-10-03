import os
import pathlib
import shutil
import webbrowser
import subprocess

pluginsFolderPath = "C:\\Program Files\\Adobe\\Common\\Plug-ins\\7.0\\MediaCore\\SHIIVA"
SCDir = os.path.dirname(os.path.abspath(__file__))
keys = os.path.join(SCDir, 'Keys.txt')

if not (os.path.exists(pluginsFolderPath)):
    os.makedirs(pluginsFolderPath)

plugins_list = os.listdir()
for plugin in plugins_list:
    plugin_path = os.path.join(SCDir, plugin)
    if plugin_path.endswith('.aex') or plugin_path.endswith('.key') or plugin_path.endswith('.lic'):
        shutil.copy(plugin_path, pluginsFolderPath)

os.startfile(keys)
webbrowser.open("https://shiivastuff.github.io/")
