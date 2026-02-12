let currentHealth = 100;
let currentArmor = 100;

// Update health display
function updateHealth(health) {
    currentHealth = Math.max(0, Math.min(100, health));
    
    const healthFill = document.getElementById('health-bar-fill');
    const healthPercentage = currentHealth;
    
    healthFill.style.width = healthPercentage + '%';
    
    // Add low health effect
    if (currentHealth <= 25) {
        healthFill.classList.add('low-health');
    } else {
        healthFill.classList.remove('low-health');
    }
}

// Update armor display
function updateArmor(armor) {
    currentArmor = Math.max(0, Math.min(100, armor));
    
    const armorValue = document.getElementById('armor-value');
    const armorSegments = document.querySelectorAll('.armor-segment');
    
    armorValue.textContent = Math.round(currentArmor);
    
    // Update segments (each segment represents 20% armor)
    const segmentsToShow = Math.ceil(currentArmor / 20);
    
    armorSegments.forEach((segment, index) => {
        if (index < segmentsToShow) {
            segment.classList.add('active');
            segment.classList.remove('empty');
        } else {
            segment.classList.remove('active');
            segment.classList.add('empty');
        }
    });
}

// Hide/Show HUD
function toggleHUD(show) {
    const hudContainer = document.getElementById('hud-container');
    hudContainer.style.display = show ? 'flex' : 'none';
}

// Listen for messages from FiveM
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'updateHealth':
            updateHealth(data.health);
            break;
            
        case 'updateArmor':
            updateArmor(data.armor);
            break;
            
        case 'updateHUD':
            updateHealth(data.health);
            updateArmor(data.armor);
            break;
            
        case 'toggleHUD':
            toggleHUD(data.show);
            break;
    }
});

// Initialize HUD
document.addEventListener('DOMContentLoaded', function() {
    updateHealth(100);
    updateArmor(0);
});

