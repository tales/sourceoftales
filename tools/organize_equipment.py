#!/usr/bin/env python

"""
equipment:
gender/slot/type/animation.png

ls sprites/equipment/male/head/leathercap
bow.png
hurt.png
slash.png
spellcast.png
thrust.png
walkcycle.png
definition.xml


* all files for one item in one directory
*

Files to be changed:
npcs.xml
items.xml
monsters.xml
AUTHORS
equipment/*





head/leathercap_male_hurt.png
head/leathercap_male.xml

"""

import shutil
import os

def replaceStringInFile(fn, fname, newpath):
    f = open(fn,'r')
    lines = f.readlines()
    f.close()

    f = open(fn,'w')
    for line in lines:
        if fname in line:
            line = line.replace(fname, newpath)
        f.write(line)
    f.close()

def movePNG(fname, newdir, newbasename):
    newfname=newdir+newbasename
    print fname, "->", newfname

    try:
        os.makedirs(newdir)
    except:
        pass
    shutil.copyfile(fname, newfname)
    os.remove(fname)
    for (dirpath, dirnames, filenames) in os.walk("sprites"):
        #print dirpath , dirnames, filenames
        for filename in filenames:
            fn = os.path.join(dirpath, filename)
            if fn.endswith('png'):
                continue
            replaceStringInFile(fn, fname[8:], newfname[8:]) # [8:] removes "sprites/"

    replaceStringInFile("AUTHORS.txt", fname[8:], newfname[8:])# [8:] removes "sprites/"
    # npcs.xml monsters.xml and items.xml not needed.

def movePNG_Johannes(fname):
    # assume fname to be relative to root of repo
    # input example:
    # sprites/equipment/walkcycle/HEAD_plate_armor_helmet.png
    # output example:
    # sprites/equipment/male/head/plate_armor_helmet/walkcycle.png
    # sprites/equipment/head/plate_armor_helmet_male_walkcycle.png
    dirs = fname.split(r"/")
    animtype = dirs[2]
    basenames = dirs[-1].split("_")
    slot = basenames[0]
    itemname = "_".join(basenames[1:]).split('.')[0]
    newdir = r"sprites/equipment/"+slot.lower()+r"/"
    newbasename = itemname+"_male_" + animtype+'.png'
    newpath = newdir + newbasename

    movePNG(fname, newdir, newbasename)

def movePNG_Luke(fname):
    # in sprites/equipment/spellcast/female_mage_blackbelt_spellcast.png
    # out sprites/equipment/female/belt/mage_blackbelt/spellcast.png
    # out sprites/equipment/unknown/blackbelt_female_spellcast.png
    dirs = fname.split(r"/")
    basenames = dirs[-1].split("_")
    itemname = "_".join(basenames[2:3]).lower()
    newbasename = itemname + "_female_" + dirs[2] + '.png'

    newbasedir = r"sprites/equipment/unknown/"
    movePNG(fname, newbasedir, newbasename)

namesJohannes = """sprites/equipment/bow/BELT_leather.png
sprites/equipment/bow/BELT_rope.png
sprites/equipment/bow/FEET_plate_armor_shoes.png
sprites/equipment/bow/FEET_shoes_brown.png
sprites/equipment/bow/HANDS_plate_armor_gloves.png
sprites/equipment/bow/HEAD_chain_armor_helmet.png
sprites/equipment/bow/HEAD_chain_armor_hood.png
sprites/equipment/bow/HEAD_leather_armor_hat.png
sprites/equipment/bow/HEAD_plate_armor_helmet.png
sprites/equipment/bow/HEAD_robe_hood.png
sprites/equipment/bow/LEGS_pants_greenish.png
sprites/equipment/bow/LEGS_plate_armor_pants.png
sprites/equipment/bow/LEGS_robe_skirt.png
sprites/equipment/bow/TORSO_chain_armor_jacket_purple.png
sprites/equipment/bow/TORSO_chain_armor_torso.png
sprites/equipment/bow/TORSO_leather_armor_bracers.png
sprites/equipment/bow/TORSO_leather_armor_shirt_white.png
sprites/equipment/bow/TORSO_leather_armor_shoulders.png
sprites/equipment/bow/TORSO_leather_armor_torso.png
sprites/equipment/bow/TORSO_plate_armor_arms_shoulders.png
sprites/equipment/bow/TORSO_plate_armor_torso.png
sprites/equipment/bow/TORSO_robe_shirt_brown.png
sprites/equipment/bow/WEAPON_arrow.png
sprites/equipment/bow/WEAPON_bow.png
sprites/equipment/hurt/BEHIND_quiver.png
sprites/equipment/hurt/BELT_leather.png
sprites/equipment/hurt/BELT_rope.png
sprites/equipment/hurt/FEET_plate_armor_shoes.png
sprites/equipment/hurt/FEET_shoes_brown.png
sprites/equipment/hurt/HANDS_plate_armor_gloves.png
sprites/equipment/hurt/HEAD_chain_armor_helmet.png
sprites/equipment/hurt/HEAD_chain_armor_hood.png
sprites/equipment/hurt/HEAD_leather_armor_hat.png
sprites/equipment/hurt/HEAD_plate_armor_helmet.png
sprites/equipment/hurt/HEAD_robe_hood.png
sprites/equipment/hurt/LEGS_pants_greenish.png
sprites/equipment/hurt/LEGS_plate_armor_pants.png
sprites/equipment/hurt/LEGS_robe_skirt.png
sprites/equipment/hurt/TORSO_chain_armor_jacket_purple.png
sprites/equipment/hurt/TORSO_chain_armor_torso.png
sprites/equipment/hurt/TORSO_leather_armor_bracers.png
sprites/equipment/hurt/TORSO_leather_armor_shirt_white.png
sprites/equipment/hurt/TORSO_leather_armor_shoulders.png
sprites/equipment/hurt/TORSO_leather_armor_torso.png
sprites/equipment/hurt/TORSO_plate_armor_arms_shoulders.png
sprites/equipment/hurt/TORSO_plate_armor_torso.png
sprites/equipment/hurt/TORSO_robe_shirt_brown.png
sprites/equipment/slash/BEHIND_quiver.png
sprites/equipment/slash/BELT_leather.png
sprites/equipment/slash/BELT_rope.png
sprites/equipment/slash/FEET_plate_armor_shoes.png
sprites/equipment/slash/FEET_shoes_brown.png
sprites/equipment/slash/HANDS_plate_armor_gloves.png
sprites/equipment/slash/HEAD_chain_armor_helmet.png
sprites/equipment/slash/HEAD_chain_armor_hood.png
sprites/equipment/slash/HEAD_leather_armor_hat.png
sprites/equipment/slash/HEAD_plate_armor_helmet.png
sprites/equipment/slash/HEAD_robe_hood.png
sprites/equipment/slash/LEGS_pants_greenish.png
sprites/equipment/slash/LEGS_plate_armor_pants.png
sprites/equipment/slash/LEGS_robe_skirt.png
sprites/equipment/slash/TORSO_chain_armor_jacket_purple.png
sprites/equipment/slash/TORSO_chain_armor_torso.png
sprites/equipment/slash/TORSO_leather_armor_bracers.png
sprites/equipment/slash/TORSO_leather_armor_shirt_white.png
sprites/equipment/slash/TORSO_leather_armor_shoulders.png
sprites/equipment/slash/TORSO_leather_armor_torso.png
sprites/equipment/slash/TORSO_plate_armor_arms_shoulders.png
sprites/equipment/slash/TORSO_plate_armor_torso.png
sprites/equipment/slash/TORSO_robe_shirt_brown.png
sprites/equipment/slash/WEAPON_dagger.png
sprites/equipment/spellcast/BEHIND_quiver.png
sprites/equipment/spellcast/BELT_leather.png
sprites/equipment/spellcast/BELT_rope.png
sprites/equipment/spellcast/FEET_plate_armor_shoes.png
sprites/equipment/spellcast/FEET_shoes_brown.png
sprites/equipment/spellcast/HANDS_plate_armor_gloves.png
sprites/equipment/spellcast/HEAD_chain_armor_helmet.png
sprites/equipment/spellcast/HEAD_chain_armor_hood.png
sprites/equipment/spellcast/HEAD_leather_armor_hat.png
sprites/equipment/spellcast/HEAD_plate_armor_helmet.png
sprites/equipment/spellcast/HEAD_robe_hood.png
sprites/equipment/spellcast/LEGS_pants_greenish.png
sprites/equipment/spellcast/LEGS_plate_armor_pants.png
sprites/equipment/spellcast/LEGS_robe_skirt.png
sprites/equipment/spellcast/TORSO_chain_armor_jacket_purple.png
sprites/equipment/spellcast/TORSO_chain_armor_torso.png
sprites/equipment/spellcast/TORSO_leather_armor_bracers.png
sprites/equipment/spellcast/TORSO_leather_armor_shirt_white.png
sprites/equipment/spellcast/TORSO_leather_armor_shoulders.png
sprites/equipment/spellcast/TORSO_leather_armor_torso.png
sprites/equipment/spellcast/TORSO_plate_armor_arms_shoulders.png
sprites/equipment/spellcast/TORSO_plate_armor_torso.png
sprites/equipment/spellcast/TORSO_robe_shirt_brown.png
sprites/equipment/thrust/BEHIND_quiver.png
sprites/equipment/thrust/BELT_leather.png
sprites/equipment/thrust/BELT_rope.png
sprites/equipment/thrust/FEET_plate_armor_shoes.png
sprites/equipment/thrust/FEET_shoes_brown.png
sprites/equipment/thrust/HANDS_plate_armor_gloves.png
sprites/equipment/thrust/HEAD_chain_armor_helmet.png
sprites/equipment/thrust/HEAD_chain_armor_hood.png
sprites/equipment/thrust/HEAD_leather_armor_hat.png
sprites/equipment/thrust/HEAD_plate_armor_helmet.png
sprites/equipment/thrust/HEAD_robe_hood.png
sprites/equipment/thrust/LEGS_pants_greenish.png
sprites/equipment/thrust/LEGS_plate_armor_pants.png
sprites/equipment/thrust/LEGS_robe_skirt.png
sprites/equipment/thrust/TORSO_chain_armor_jacket_purple.png
sprites/equipment/thrust/TORSO_chain_armor_torso.png
sprites/equipment/thrust/TORSO_leather_armor_bracers.png
sprites/equipment/thrust/TORSO_leather_armor_shirt_white.png
sprites/equipment/thrust/TORSO_leather_armor_shoulders.png
sprites/equipment/thrust/TORSO_leather_armor_torso.png
sprites/equipment/thrust/TORSO_plate_armor_arms_shoulders.png
sprites/equipment/thrust/TORSO_plate_armor_torso.png
sprites/equipment/thrust/TORSO_robe_shirt_brown.png
sprites/equipment/thrust/WEAPON_shield_cutout_body.png
sprites/equipment/thrust/WEAPON_shield_cutout_chain_armor_helmet.png
sprites/equipment/thrust/WEAPON_spear.png
sprites/equipment/thrust/WEAPON_staff.png
sprites/equipment/walkcycle/BEHIND_quiver.png
sprites/equipment/walkcycle/BELT_leather.png
sprites/equipment/walkcycle/BELT_rope.png
sprites/equipment/walkcycle/FEET_plate_armor_shoes.png
sprites/equipment/walkcycle/FEET_shoes_brown.png
sprites/equipment/walkcycle/HANDS_plate_armor_gloves.png
sprites/equipment/walkcycle/HEAD_chain_armor_helmet.png
sprites/equipment/walkcycle/HEAD_chain_armor_hood.png
sprites/equipment/walkcycle/HEAD_leather_armor_hat.png
sprites/equipment/walkcycle/HEAD_plate_armor_helmet.png
sprites/equipment/walkcycle/HEAD_robe_hood.png
sprites/equipment/walkcycle/LEGS_pants_greenish.png
sprites/equipment/walkcycle/LEGS_plate_armor_pants.png
sprites/equipment/walkcycle/LEGS_robe_skirt.png
sprites/equipment/walkcycle/TORSO_chain_armor_jacket_purple.png
sprites/equipment/walkcycle/TORSO_chain_armor_torso.png
sprites/equipment/walkcycle/TORSO_leather_armor_bracers.png
sprites/equipment/walkcycle/TORSO_leather_armor_shirt_white.png
sprites/equipment/walkcycle/TORSO_leather_armor_shoulders.png
sprites/equipment/walkcycle/TORSO_leather_armor_torso.png
sprites/equipment/walkcycle/TORSO_plate_armor_arms_shoulders.png
sprites/equipment/walkcycle/TORSO_plate_armor_torso.png
sprites/equipment/walkcycle/TORSO_robe_shirt_brown.png
sprites/equipment/walkcycle/WEAPON_shield_cutout_body.png
sprites/equipment/walkcycle/WEAPON_shield_cutout_chain_armor_helmet.png"""

for n in namesJohannes.split():
    movePNG_Johannes(n)
    pass

namesLuke="""sprites/equipment/hurt/female_mage_blackbelt_hurt.png
sprites/equipment/hurt/female_mage_blackhair_hurt.png
sprites/equipment/hurt/female_mage_blackrobe_hurt.png
sprites/equipment/hurt/female_mage_blackslippers_hurt.png
sprites/equipment/hurt/female_mage_bluerobe_hurt.png
sprites/equipment/hurt/female_mage_bronzebelt_hurt.png
sprites/equipment/hurt/female_mage_bronzebuckle_hurt.png
sprites/equipment/hurt/female_mage_bronzenecklace_hurt.png
sprites/equipment/hurt/female_mage_bronzetiara_hurt.png
sprites/equipment/hurt/female_mage_brownbelt_hurt.png
sprites/equipment/hurt/female_mage_brownhair_hurt.png
sprites/equipment/hurt/female_mage_brownrobe_hurt.png
sprites/equipment/hurt/female_mage_brownslippers_hurt.png
sprites/equipment/hurt/female_mage_darkblondehair_hurt.png
sprites/equipment/hurt/female_mage_darkbrownrobe_hurt.png
sprites/equipment/hurt/female_mage_darkgrayrobe_hurt.png
sprites/equipment/hurt/female_mage_forestrobe_hurt.png
sprites/equipment/hurt/female_mage_goldbelt_hurt.png
sprites/equipment/hurt/female_mage_goldbuckle_hurt.png
sprites/equipment/hurt/female_mage_goldnecklace_hurt.png
sprites/equipment/hurt/female_mage_goldtiara_hurt.png
sprites/equipment/hurt/female_mage_grayhair_hurt.png
sprites/equipment/hurt/female_mage_grayslippers_hurt.png
sprites/equipment/hurt/female_mage_ironbelt_hurt.png
sprites/equipment/hurt/female_mage_ironbuckle_hurt.png
sprites/equipment/hurt/female_mage_ironnecklace_hurt.png
sprites/equipment/hurt/female_mage_irontiara_hurt.png
sprites/equipment/hurt/female_mage_lightblondehair_hurt.png
sprites/equipment/hurt/female_mage_lightgrayrobe_hurt.png
sprites/equipment/hurt/female_mage_purplerobe_hurt.png
sprites/equipment/hurt/female_mage_redrobe_hurt.png
sprites/equipment/hurt/female_mage_silverbelt_hurt.png
sprites/equipment/hurt/female_mage_silverbuckle_hurt.png
sprites/equipment/hurt/female_mage_silvernecklace_hurt.png
sprites/equipment/hurt/female_mage_silvertiara_hurt.png
sprites/equipment/hurt/female_mage_whitehair_hurt.png
sprites/equipment/hurt/female_mage_whiterobe_hurt.png
sprites/equipment/hurt/female_mage_whiteslippers_hurt.png
sprites/equipment/slash/female_mage_blackbelt_slash.png
sprites/equipment/slash/female_mage_blackhair_slash.png
sprites/equipment/slash/female_mage_blackrobe_slash.png
sprites/equipment/slash/female_mage_blackslippers_slash.png
sprites/equipment/slash/female_mage_bluerobe_slash.png
sprites/equipment/slash/female_mage_bronzebelt_slash.png
sprites/equipment/slash/female_mage_bronzebuckle_slash.png
sprites/equipment/slash/female_mage_bronzenecklace_slash.png
sprites/equipment/slash/female_mage_bronzetiara_slash.png
sprites/equipment/slash/female_mage_brownbelt_slash.png
sprites/equipment/slash/female_mage_brownhair_slash.png
sprites/equipment/slash/female_mage_brownrobe_slash.png
sprites/equipment/slash/female_mage_brownslippers_slash.png
sprites/equipment/slash/female_mage_darkblondehair_slash.png
sprites/equipment/slash/female_mage_darkbrownrobe_slash.png
sprites/equipment/slash/female_mage_darkgrayrobe_slash.png
sprites/equipment/slash/female_mage_forestrobe_slash.png
sprites/equipment/slash/female_mage_goldbelt_slash.png
sprites/equipment/slash/female_mage_goldbuckle_slash.png
sprites/equipment/slash/female_mage_goldnecklace_slash.png
sprites/equipment/slash/female_mage_goldtiara_slash.png
sprites/equipment/slash/female_mage_grayhair_slash.png
sprites/equipment/slash/female_mage_grayslippers_slash.png
sprites/equipment/slash/female_mage_ironbelt_slash.png
sprites/equipment/slash/female_mage_ironbuckle_slash.png
sprites/equipment/slash/female_mage_ironnecklace_slash.png
sprites/equipment/slash/female_mage_irontiara_slash.png
sprites/equipment/slash/female_mage_lightblondehair_slash.png
sprites/equipment/slash/female_mage_lightgrayrobe_slash.png
sprites/equipment/slash/female_mage_purplerobe_slash.png
sprites/equipment/slash/female_mage_redrobe_slash.png
sprites/equipment/slash/female_mage_silverbelt_slash.png
sprites/equipment/slash/female_mage_silverbuckle_slash.png
sprites/equipment/slash/female_mage_silvernecklace_slash.png
sprites/equipment/slash/female_mage_silvertiara_slash.png
sprites/equipment/slash/female_mage_whitehair_slash.png
sprites/equipment/slash/female_mage_whiterobe_slash.png
sprites/equipment/slash/female_mage_whiteslippers_slash.png
sprites/equipment/spellcast/female_mage_blackbelt_spellcast.png
sprites/equipment/spellcast/female_mage_blackhair_spellcast.png
sprites/equipment/spellcast/female_mage_blackrobe_spellcast.png
sprites/equipment/spellcast/female_mage_blackslippers_spellcast.png
sprites/equipment/spellcast/female_mage_bluerobe_spellcast.png
sprites/equipment/spellcast/female_mage_bronzebelt_spellcast.png
sprites/equipment/spellcast/female_mage_bronzebuckle_spellcast.png
sprites/equipment/spellcast/female_mage_bronzenecklace_spellcast.png
sprites/equipment/spellcast/female_mage_bronzetiara_spellcast.png
sprites/equipment/spellcast/female_mage_brownbelt_spellcast.png
sprites/equipment/spellcast/female_mage_brownhair_spellcast.png
sprites/equipment/spellcast/female_mage_brownrobe_spellcast.png
sprites/equipment/spellcast/female_mage_brownslippers_spellcast.png
sprites/equipment/spellcast/female_mage_darkblondehair_spellcast.png
sprites/equipment/spellcast/female_mage_darkbrownrobe_spellcast.png
sprites/equipment/spellcast/female_mage_darkgrayrobe_spellcast.png
sprites/equipment/spellcast/female_mage_forestrobe_spellcast.png
sprites/equipment/spellcast/female_mage_goldbelt_spellcast.png
sprites/equipment/spellcast/female_mage_goldbuckle_spellcast.png
sprites/equipment/spellcast/female_mage_goldnecklace_spellcast.png
sprites/equipment/spellcast/female_mage_goldtiara_spellcast.png
sprites/equipment/spellcast/female_mage_grayhair_spellcast.png
sprites/equipment/spellcast/female_mage_grayslippers_spellcast.png
sprites/equipment/spellcast/female_mage_ironbelt_spellcast.png
sprites/equipment/spellcast/female_mage_ironbuckle_spellcast.png
sprites/equipment/spellcast/female_mage_ironnecklace_spellcast.png
sprites/equipment/spellcast/female_mage_irontiara_spellcast.png
sprites/equipment/spellcast/female_mage_lightblondehair_spellcast.png
sprites/equipment/spellcast/female_mage_lightgrayrobe_spellcast.png
sprites/equipment/spellcast/female_mage_purplerobe_spellcast.png
sprites/equipment/spellcast/female_mage_redrobe_spellcast.png
sprites/equipment/spellcast/female_mage_silverbelt_spellcast.png
sprites/equipment/spellcast/female_mage_silverbuckle_spellcast.png
sprites/equipment/spellcast/female_mage_silvernecklace_spellcast.png
sprites/equipment/spellcast/female_mage_silvertiara_spellcast.png
sprites/equipment/spellcast/female_mage_whitehair_spellcast.png
sprites/equipment/spellcast/female_mage_whiterobe_spellcast.png
sprites/equipment/spellcast/female_mage_whiteslippers_spellcast.png
sprites/equipment/walkcycle/female_mage_blackbelt_walkcycle.png
sprites/equipment/walkcycle/female_mage_blackhair_walkcycle.png
sprites/equipment/walkcycle/female_mage_blackrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_blackslippers_walkcycle.png
sprites/equipment/walkcycle/female_mage_bluerobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_bronzebelt_walkcycle.png
sprites/equipment/walkcycle/female_mage_bronzebuckle_walkcycle.png
sprites/equipment/walkcycle/female_mage_bronzenecklace_walkcycle.png
sprites/equipment/walkcycle/female_mage_bronzetiara_walkcycle.png
sprites/equipment/walkcycle/female_mage_brownbelt_walkcycle.png
sprites/equipment/walkcycle/female_mage_brownhair_walkcycle.png
sprites/equipment/walkcycle/female_mage_brownrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_brownslippers_walkcycle.png
sprites/equipment/walkcycle/female_mage_darkblondehair_walkcycle.png
sprites/equipment/walkcycle/female_mage_darkbrownrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_darkgrayrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_forestrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_goldbelt_walkcycle.png
sprites/equipment/walkcycle/female_mage_goldbuckle_walkcycle.png
sprites/equipment/walkcycle/female_mage_goldnecklace_walkcycle.png
sprites/equipment/walkcycle/female_mage_goldtiara_walkcycle.png
sprites/equipment/walkcycle/female_mage_grayhair_walkcycle.png
sprites/equipment/walkcycle/female_mage_grayslippers_walkcycle.png
sprites/equipment/walkcycle/female_mage_ironbelt_walkcycle.png
sprites/equipment/walkcycle/female_mage_ironbuckle_walkcycle.png
sprites/equipment/walkcycle/female_mage_ironnecklace_walkcycle.png
sprites/equipment/walkcycle/female_mage_irontiara_walkcycle.png
sprites/equipment/walkcycle/female_mage_lightblondehair_walkcycle.png
sprites/equipment/walkcycle/female_mage_lightgrayrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_purplerobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_redrobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_silverbelt_walkcycle.png
sprites/equipment/walkcycle/female_mage_silverbuckle_walkcycle.png
sprites/equipment/walkcycle/female_mage_silvernecklace_walkcycle.png
sprites/equipment/walkcycle/female_mage_silvertiara_walkcycle.png
sprites/equipment/walkcycle/female_mage_whitehair_walkcycle.png
sprites/equipment/walkcycle/female_mage_whiterobe_walkcycle.png
sprites/equipment/walkcycle/female_mage_whiteslippers_walkcycle.png"""

for n in namesLuke.split():
    movePNG_Luke(n)
    pass
