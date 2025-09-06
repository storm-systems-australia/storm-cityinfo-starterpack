---------------------------------------------------------------------------------------------------------

These Scripts are required to be together, you can disable stuff on the guide to just have a starter pack.
---------------------------------------------------------------------------------------------------------

   ███████╗████████╗ ██████╗ ██████╗ ███╗   ███╗     ███████╗██╗   ██╗████████╗███████╗███╗   ███╗███████╗

&nbsp;  ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗████╗ ████║     ██╔════╝██║   ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝

&nbsp;  ███████╗   ██║   ██║   ██║██████╔╝██╔████╔██║     █████╗  ██║   ██║   ██║   █████╗  ██╔████╔██║███████╗

&nbsp;  ╚════██║   ██║   ██║   ██║██╔═══╝ ██║╚██╔╝██║     ██╔══╝  ██║   ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║

&nbsp;  ███████║   ██║   ╚██████╔╝██║     ██║ ╚═╝ ██║     ██║     ╚██████╔╝   ██║   ███████╗██║ ╚═╝ ██║███████║

&nbsp;  ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ╚═╝     ╚═╝      ╚═════╝    ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝


---OX INVENTORY---
return {
    \['redbull'] = {

&nbsp;       label = 'Red Bull',

&nbsp;       weight = 300,

&nbsp;       client = {

&nbsp;           status = { thirst = 150000 },

&nbsp;           anim = { dict = 'mp\_player\_intdrink', clip = 'loop\_bottle' },

&nbsp;           prop = { model = `prop\_energy\_drink`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },

&nbsp;           usetime = 2500,

&nbsp;           cancel = true,

&nbsp;           notification = 'You drank a can of Red Bull and feel energized'

&nbsp;       }

&nbsp;   },

&nbsp;   \['phone'] = {

&nbsp;       label = 'Phone',

&nbsp;       description = 'A high-end Smartphone.',

&nbsp;       weight = 200,

&nbsp;   },

&nbsp;   \['burger'] = {

&nbsp;       label = 'Burger',

&nbsp;       weight = 400,

&nbsp;       client = {

&nbsp;           status = { hunger = 250000 },

&nbsp;           anim = { dict = 'mp\_player\_inteat@burger', clip = 'mp\_player\_int\_eat\_burger' },

&nbsp;           prop = { model = `prop\_food\_bs\_burger2`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },

&nbsp;           usetime = 2500,

&nbsp;           cancel = true,

&nbsp;           notification = 'You ate a juicy burger'

&nbsp;       }

&nbsp;   },

}    



