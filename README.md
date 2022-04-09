# End-Ghost-Keys
Putting an end the haunting ghost keys (CTRL, ALT and SHIFT) when using Oblitum's Interception

The script `endghostkeys.sh` is basically a tool to edit the `keyremap.ini` from Interception, and to turn 1 macro into 2 macros:
- The first macro will send your initial key combo when pressing down your initial key trigger ->
*the only modification will be adding* `_D` *at the end of the macro's name (1st line)*

- The second macro will be making sure there are no ghost keys, by sending UP events for CTRL|ALT|SHIFT (left and right) when releasing your trigger key ->
*adding* `_U` *at the end of the name (1st line), adding +1 on the last digit of the trigger key's ID (3rd line), and it will be using this combo*: `2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|` *(4th line)*

What this basically means, is that for each macro, you will have 2 macros. When pressing down your key trigger, it will use the initial combo you created in Interception, but when you let go of the key, it will make sure the SHIFT, ALT and CTRL keys (left and right) have been fully released afterwards.

# How to use it

> Note that this is a bash script (Linux). The script must be run in a linux terminal before bringing the result back to your Windows machine. I am sorry for those who don't have a linux terminal, but I didn't know how to do this with the tools provided in Windows.
> 
> My solution for Windows only users would be to install Ubuntu 20.04 LTS from the Microsoft Store, and follow the tutorial below with the Ubuntu terminal (you will need to enable the Windows subsystem for Linux and reboot first).
> 
> Or else, you could simply SSH into a linux machine to operate the script, and bring the result back to your Windows machine.

**Step 1**: Copy/paste this command in the terminal to create the script file:

```
nano endghostkeys.sh
```

Then paste these lines:

```sh
#!/bin/bash
# Recuperating lines from input file and deleting them
head -n 1 keys.ini > line1D
head -n 1 keys.ini > line1U
sed -i '1d' keys.ini
head -n 1 keys.ini > line2D
head -n 1 keys.ini > line2U
sed -i '1d' keys.ini
head -n 1 keys.ini > line3D
head -n 1 keys.ini > line3U
sed -i '1d' keys.ini
head -n 1 keys.ini > line4D
sed -i '1d' keys.ini

# Creating 2 new macros (one for event DOWN and one for event UP)
sed -i 's/..$//' line1D
sed -i 's/$/_D]/' line1D
sed -i 's/..$//' line1U
sed -i 's/$/_U]/' line1U

# Replacing trigger with +1 at last number for UP event macro
str0=`cat line3U`
str1=`echo $str0 | sed -e 's/.*\(..\)$/\1/'`
str1=$(echo "$str1" | tr -d $'\r')
line3Ux=`sed 's/..$//' line3U`
line3Uy=`echo 1+"$str1" | bc`
echo "$line3Ux$line3Uy" > line3U

# Replacing UP event with ShiftUp,AltUp,CtrlUp
echo "combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|" > line4U

# Creating the output file if it doesn't already exist
touch output_keys.ini

# Output each line individually
cat line1D >> output_keys.ini
cat line2D >> output_keys.ini
cat line3D >> output_keys.ini
cat line4D >> output_keys.ini
cat line1U >> output_keys.ini
cat line2U >> output_keys.ini
cat line3U >> output_keys.ini
cat line4U >> output_keys.ini
```

Then, save the file with `CTRL+O`, `Enter`, and `CTRL+X`

**Step 2**: Now you need to create a copy of your keyremap.ini and rename it 'keys.ini' (I have purposefully changed it so you would not apply the script on the original .ini file, always keep backups!)

To do so, simply use the command below:

```
nano keys.ini
```

Then paste the full content of your `keyremap.ini` (or only specific macros, for example the ones containing CTRL, ALT or SHIFT),

Here is what your `keys.ini` file should look like

```ini
[ID75_INC_assignments_txt_file]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=6,0,0
combo=1d,0,0|2a,0,0|3e,0,0|3e,0,1|2a,0,1|1d,0,1
[ID75_SN_File]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=12,0,0
combo=1d,0,0|2a,0,0|3f,0,0|3f,0,1|2a,0,1|1d,0,1
[ID75_Focus_Remedy]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=1d,0,0
combo=1d,0,0|2a,0,0|26,0,0|26,0,1|2a,0,1|1d,0,1
[ID75_Focus_AD]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=5b,0,2
combo=1d,0,0|2a,0,0|27,0,0|27,0,1|2a,0,1|1d,0,1
[ID75_Focus_SCCM_Console]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=38,0,0
combo=1d,0,0|2a,0,0|31,0,0|31,0,1|2a,0,1|1d,0,1
```

Then, save the file using `CTRL+O`, `Enter`, and `CTRL+X`

**Step 3**: Now that the script and the input file are in the same folder, you can execute the script with the command below. It needs to be executed once per macro:

```
sh endghostkeys.sh
```

So as in this example if you have 5 macros (which should be 20 lines in the input file), run the script 5 times:

```
sh endghostkeys.sh
sh endghostkeys.sh
sh endghostkeys.sh
sh endghostkeys.sh
sh endghostkeys.sh
```

# What the `output_keys.ini` file should look like

View the result with this command:

```
cat output_keys.ini
```

```ini
[ID75_INC_assignments_txt_file_D]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=6,0,0
combo=1d,0,0|2a,0,0|3e,0,0|3e,0,1|2a,0,1|1d,0,1
[ID75_INC_assignments_txt_file_U]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=6,0,1
combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|
[ID75_SN_File_D]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=12,0,0
combo=1d,0,0|2a,0,0|3f,0,0|3f,0,1|2a,0,1|1d,0,1
[ID75_SN_File_U]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=12,0,1
combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|
[ID75_Focus_Remedy_D]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=1d,0,0
combo=1d,0,0|2a,0,0|26,0,0|26,0,1|2a,0,1|1d,0,1
[ID75_Focus_Remedy_U]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=1d,0,1
combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|
[ID75_Focus_AD_D]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=5b,0,2
combo=1d,0,0|2a,0,0|27,0,0|27,0,1|2a,0,1|1d,0,1
[ID75_Focus_AD_U]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=5b,0,3
combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|
[ID75_Focus_SCCM_Console_D]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=38,0,0
combo=1d,0,0|2a,0,0|31,0,0|31,0,1|2a,0,1|1d,0,1
[ID75_Focus_SCCM_Console_U]
device=HID\VID_6964&PID_0075&REV_0001&MI_00
trigger=38,0,1
combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|
```

Then, you can copy/paste the result back into your original `keyremap.ini` (make sure to have backups of this file!)

If you're adding new macros in the future and need to run the script again, only input the new macros in `keys.ini` instead of the entire `keyremap.ini`, and then replace them with the output.

And that's it! Now each time you release one of your trigger keys, it will always ensure these ghost keys never haunt you...
