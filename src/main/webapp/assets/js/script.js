// SkillForge JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Initialize any components
    console.log('SkillForge scripts initialized');
    
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if(targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if(targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Mobile menu toggle functionality can be added here
    
    // Course filtering functionality can be added here
    
    // Form validation for login/signup can be added here
});