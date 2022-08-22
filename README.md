# snipe-backpack
Backpack script to create backpack items as stashes


-  Add the following items to shared.lua/items.lua

```lua
    	["smallbackpack"]= {["name"] = "smallbackpack", ["label"] = "Small Backpack", 		["weight"] = 2000, 		["type"] = "item", 		["image"] = "backpack.png", ["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "Small Backpack"},

	["mediumbackpack"]= {["name"] = "mediumbackpack", ["label"] = "Medium Backpack", 		["weight"] = 2000, 		["type"] = "item", 		["image"] = "backpack.png", ["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "Medium Backpack"},

	["largebackpack"]= {["name"] = "largebackpack", ["label"] = "Large Backpack", 		["weight"] = 2000, 		["type"] = "item", 		["image"] = "backpack.png", ["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "Large Backpack"},

```

- Make the following changes in inventory/html/app.js to display the backpack id when you hover over the item (optional)

Look for this logic
```js
else if (itemData.name == "labkey") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html("<p>Lab: " + itemData.info.lab + "</p>");
            
        } 
```

and add the following lines below it, like this

```js
else if (itemData.name == "labkey") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Lab: " + itemData.info.lab + "</p>");
} else if (itemData.name == "smallbackpack") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Backpack ID: " + itemData.info.backpackid + "</p>");
} else if (itemData.name == "mediumbackpack") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Backpack ID: " + itemData.info.backpackid + "</p>");
} else if (itemData.name == "largebackpack") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Backpack ID: " + itemData.info.backpackid + "</p>");
}
