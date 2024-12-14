    # This file should ensure the existence of records required to run the application in every environment (production,
    # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
    # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
    #
    # Example:
    #

    [
        { name: 'Male', option_type: 'gender' },
        { name: 'Female', option_type: 'gender' },

        { name: 'Person', option_type: 'Victims' },
        { name: 'Place', option_type: 'Victims' },
        { name: 'Animal', option_type: 'Victims' },

        { name: 'Person', option_type: 'Suspects' },
        { name: 'Place', option_type: 'Suspects' },
        { name: 'Animal', option_type: 'Suspects' },



        { name: 'Firearms', option_type: 'Weapons/Tools used' },
        { name: 'Sharp Weapons', option_type: 'Weapons/Tools used' },
        { name: 'Blunt Weapons', option_type: 'Weapons/Tools used' },
        { name: 'Explosives', option_type: 'Weapons/Tools used' },
        { name: 'Chemical Weapons', option_type: 'Weapons/Tools used' },
        { name: 'Improvised Weapons', option_type: 'Weapons/Tools used' },
        { name: 'Miscellaneous Weapons', option_type: 'Weapons/Tools used' },

        { name: 'Vehicle', option_type: 'Items Affected' },

        { name: 'Reported', option_type: 'Incident Status' },
        { name: 'TRUE', option_type: 'Incident Status' },
        { name: 'REFUSED', option_type: 'Incident Status' },
        { name: 'UNDER INVESTIGATION', option_type: 'Incident Status' },
        { name: 'CLOSED', option_type: 'Incident Status' },
        { name: 'SENT TO AG', option_type: 'Incident Status' },
        { name: 'SENT TO COURT', option_type: 'Incident Status' },
        { name: 'UNDER INVESTIGATION', option_type: 'Incident Status' },
        { name: 'UNDER INVESTIGATION', option_type: 'Incident Status' },
        { name: 'UNDER TRIAL', option_type: 'Incident Status' },
        { name: 'ACQUITTED', option_type: 'Incident Status' },
        { name: 'CONVICTED', option_type: 'Incident Status' }


    ].each do |r|
        Option.find_or_create_by!(r)
    end

    [
        { "name": "Handgun", "is_implement": true, "nature": "Firearms" },
        { "name": "Shotgun", "is_implement": true, "nature": "Firearms" },
        { "name": "Rifle", "is_implement": true, "nature": "Firearms" },
        { "name": "Automatic Weapon", "is_implement": true, "nature": "Firearms" },
        { "name": "Revolver", "is_implement": true, "nature": "Firearms" },
        { "name": "Machine Gun", "is_implement": true, "nature": "Firearms" },
        { "name": "Knife", "is_implement": true, "nature": "Sharp Weapons" },
        { "name": "Machete", "is_implement": true, "nature": "Sharp Weapons" },
        { "name": "Sword", "is_implement": true, "nature": "Sharp Weapons" },
        { "name": "Switchblade", "is_implement": true, "nature": "Sharp Weapons" },
        { "name": "Box Cutter", "is_implement": true, "nature": "Sharp Weapons" },
        { "name": "Scissors", "is_implement": true, "nature": "Sharp Weapons" },
        { "name": "Baseball Bat", "is_implement": true, "nature": "Blunt Weapons" },
        { "name": "Hammer", "is_implement": true, "nature": "Blunt Weapons" },
        { "name": "Crowbar", "is_implement": true, "nature": "Blunt Weapons" },
        { "name": "Wrench", "is_implement": true, "nature": "Blunt Weapons" },
        { "name": "Metal Rod", "is_implement": true, "nature": "Blunt Weapons" },
        { "name": "Brick", "is_implement": true, "nature": "Blunt Weapons" },
        { "name": "Grenade", "is_implement": true, "nature": "Explosives" },
        { "name": "Molotov Cocktail", "is_implement": true, "nature": "Explosives" },
        { "name": "Pipe Bomb", "is_implement": true, "nature": "Explosives" },
        { "name": "Dynamite", "is_implement": true, "nature": "Explosives" },
        { "name": "Improvised Explosive Device (IED)", "is_implement": true, "nature": "Explosives" },
        { "name": "Acid", "is_implement": true, "nature": "Chemical Weapons" },
        { "name": "Poison", "is_implement": true, "nature": "Chemical Weapons" },
        { "name": "Tear Gas", "is_implement": true, "nature": "Chemical Weapons" },
        { "name": "Pepper Spray", "is_implement": true, "nature": "Chemical Weapons" },
        { "name": "Glass Bottle", "is_implement": true, "nature": "Improvised Weapons" },
        { "name": "Rock", "is_implement": true, "nature": "Improvised Weapons" },
        { "name": "Chair", "is_implement": true, "nature": "Improvised Weapons" },
        { "name": "Rope", "is_implement": true, "nature": "Improvised Weapons" },
        { "name": "Chains", "is_implement": true, "nature": "Improvised Weapons" },
        { "name": "Bow and Arrow", "is_implement": true, "nature": "Miscellaneous Weapons" },
        { "name": "Crossbow", "is_implement": true, "nature": "Miscellaneous Weapons" },
        { "name": "Slingshot", "is_implement": true, "nature": "Miscellaneous Weapons" },
        { "name": "Taser", "is_implement": true, "nature": "Miscellaneous Weapons" },
        { "name": "Brass Knuckles", "is_implement": true, "nature": "Miscellaneous Weapons" }
    ].each do |r|
        Item.find_or_create_by!(r)
    end

    [
        { "email": 'taichobill@gmail.com', 'validated_phone': '+233541928449', 'password': '123456' },
        { "email": 'porlovec4c@gmail.com', 'validated_phone': '+233248107723', 'password': '123456' },
        { "email": 'master.eadututu@gmail.com', 'validated_phone': '+233247040753', 'password': '123456' }
    ].each do |r|
        User.find_or_create_by!(r)
    end
