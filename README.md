# 🎮 zx_pvphud

Modern and minimalist HUD for FiveM servers focused on PVP gameplay. Compatible with ESX, QB-Core, and standalone servers.

## ✨ Features

- ❤️ **Health Bar** - Smooth health indicator with visual warning at low HP
- 🛡️ **Armor System** - Segmented armor display (5 segments of 20% each)
- 🎨 **Customizable Design** - Change colors and position in CSS
- 🔄 **Real-time Updates** - Instant value updates (200ms interval)
- 🎯 **Framework Compatibility** - Automatic detection of ESX/QB-Core/Standalone
- 👁️ **Toggle Function** - Hide/show HUD with command
- 📱 **Responsive Design** - Automatic scaling for different resolutions
- ⚡ **Optimized** - Minimal server performance impact (0.00-0.01ms)

## 📥 Installation

1. **Download the resource** from GitHub releases or clone the repository
2. **Rename the folder** to `pvp-hud` (if needed)
3. **Copy the folder** to your FiveM server resources directory
4. **Add to server.cfg**:
```cfg
ensure pvp-hud
```
5. **Restart the server** or use `refresh` and `ensure pvp-hud` commands

### Dependencies

- **ox_lib** - For notifications (optional, works without it)
- **ESX/QB-Core** - Optional, automatically detected

## ⚙️ Configuration

All settings can be found in the `config.lua` file:

### General Settings
```lua
Config.UpdateInterval = 200  -- Update interval in ms (200ms = 5 times per second)
Config.ShowHUD = true        -- Show HUD on startup
Config.DisableDefaultHUD = true  -- Disable default GTA HUD
```

### Framework
```lua
Config.Framework = 'auto'  -- 'auto', 'esx', 'qb', or 'standalone'
```

### Notifications
```lua
Config.Notifications = {
    enabled = true,
    hudToggle = true  -- Show notification when toggling HUD
}
```

### HUD Elements
```lua
Config.Elements = {
    health = {
        enabled = true,
        showIcon = true
    },
    armor = {
        enabled = true,
        showIcon = true,
        showSegments = true,
        showValue = true
    }
}
```

## 🎨 Color Customization

You can customize colors and appearance in the `html/style.css` file:

### Health Bar Colors
```css
#health-bar-fill {
    background: linear-gradient(90deg, 
        #333333 0%,   /* Dark gray */
        #222222 50%,  /* Medium gray */
        #111111 100%  /* Black */
    );
}
```

### Armor Segment Colors
```css
.armor-segment.active {
    background: rgba(255, 255, 255, 0.9);  /* White */
    box-shadow: 0 0 8px rgba(255, 255, 255, 0.6);
}
```

### HUD Position
```css
#hud-container {
    bottom: 50px;  /* Distance from bottom edge */
    left: 50%;     /* Horizontal position */
}
```

## 🎮 Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/hud` | Toggle HUD visibility (on/off) | All players |
| `/reloadhud` | Reload HUD for player | Admin/Console |

## 🔍 Additional Features

- **Automatic Framework Detection** - Supports ESX, QB-Core, and standalone
- **Hide on Death** - HUD automatically hides when player dies
- **Responsive Scaling** - Adapts to different screen resolutions
- **Default HUD Disabled** - Automatically disables GTA V health/armor/minimap
- **Smooth Animations** - Smooth transitions between values
- **Low Health Warning** - Red pulsing effect at low health (below 25%)
- **Segmented Armor** - Visual representation of armor in 20% segments

## 📜 License

This project is open-source and freely available for use on FiveM servers.

## 👨‍💻 Developer

**ZydeDevelopment**

## 💬 Support

Need help or have suggestions for improvements?

🔗 **Discord Server**: https://discord.gg/6xUjEAryYX

---

⭐ If you like this resource, give it a star on GitHub!
