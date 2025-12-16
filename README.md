1. Install MelonLoader
2. Run Game until T-Pose and then close game
3. Put the CustomShiftstones.dll in your mods folder
4. Run Game

## Custom Shiftstone Models

Allows for custom shiftstones models to be equipped!

### Use

In the userdata folder there are example Shiftstones for Charge, Stubborn, Surge, Flow and Vigor. To use these drag them out of Example Models and into Shiftstone Models
To get more shiftstone models check out the Modding Discord

### Creating Models

##### Shiftstone Creator Version

You can create your own shiftstones using the Shiftstone Creator packaged with this mod. This is considerably easier than the AssetBundle method but much more limited. You will have to build your shiftstone out of primitive shapes and many features are not implemented yet. TLDR; This is a work in progress.



You can create your object out of primitives and position, scale and rotate them how you see fit (If youre getting tired of manually inputting values try click and drag on the arrows) There are options for metallic, emission, color and the ability to give an object the shiftstone material. There is a charge stone model that you can base the size of your shiftstone off. When you are done, hit export and pick a location to save the file.



To load the shiftstone into the game, rename the file to the name of the shiftstone you want to replace in all caps (E.G: VIGOR, VOLATILE) and put it in the UserData/ShifstoneModels folder.

##### Assetbundle Version

Each Shiftstone Model is an AssetBundle containing a Prefab.
Check the modding discord on how to create one.
The File itself must be named as the stone you want to replace in all caps. The prefab in the bundle must be called "Stone". With the newest update there are basically no limitations.
Naming any object with a "%" in it will make it take the default shiftstone material (Make sure it has a meshRenderer).
Naming any object with a "$" in it will make any Animation, AudioSource and ParticleSystem Components on it play when the shiftstone activates.

