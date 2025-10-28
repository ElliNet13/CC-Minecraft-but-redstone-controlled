# CC:Minecraft but it uses redstone to control it

This is [CC:Minecraft](https://github.com/CC-Minecraft/CC-Minecraft) but it uses redstone to control it.

CC:Minecraft is a mostly complete game emulating Minecraft within ComputerCraft in 3d made using the Pine3D graphics library, though it is very simplified. You can generate many different worlds, each with infinite chunks to build in with your limited number of blocks.

And now you can play it using redstone!

You may need to change the names of each redstone relay to match your setup.

You also if you want the camera to be more controlled you may need to change
```lua
local turnSpeed = 180
```
to something like
```lua
local turnSpeed = 180/5
```

You will need to run `wget run https://pinestore.cc/d/2` yourself.

Here's some pictures of it in action:
![Main screeen](https://ellinet13.github.io/READMEAssets/CC-Minecraft-Controller/CCMinecraftMachine.png)
![Turned off](https://ellinet13.github.io/READMEAssets/CC-Minecraft-Controller/poweroff.png)
![World selector screen](https://ellinet13.github.io/READMEAssets/CC-Minecraft-Controller/worldselect.png)
![In game](https://ellinet13.github.io/READMEAssets/CC-Minecraft-Controller/ingame.png)
![The back](https://ellinet13.github.io/READMEAssets/CC-Minecraft-Controller/back.png)