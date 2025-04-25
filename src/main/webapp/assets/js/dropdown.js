/**
 * Profile Dropdown Menu Functionality
 */
(function() {
    // Initialize dropdown functionality
    function initProfileDropdown() {
        // Get dropdown elements
        const dropdownToggle = document.getElementById('profileDropdownToggle');
        const dropdownContainer = document.getElementById('profileDropdownContainer');
        const dropdownMenu = document.getElementById('profileDropdownMenu');

        // If any element is missing, exit
        if (!dropdownToggle || !dropdownContainer || !dropdownMenu) {
            return;
        }

        // Use CSS classes for z-index instead of inline styles
        // This prevents style conflicts and makes maintenance easier
        dropdownContainer.classList.add('dropdown-container');
        dropdownMenu.classList.add('dropdown-menu-layer');

        // Remove any existing event listeners by cloning and replacing the toggle
        const newToggle = dropdownToggle.cloneNode(true);
        dropdownToggle.parentNode.replaceChild(newToggle, dropdownToggle);

        // Toggle dropdown on click
        newToggle.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            // Close all other dropdowns first
            document.querySelectorAll('.profile-dropdown.show').forEach(function(el) {
                if (el !== dropdownContainer) {
                    el.classList.remove('show');
                }
            });

            // Toggle this dropdown
            dropdownContainer.classList.toggle('show');

            // Add a one-time event listener to close when clicking outside
            if (dropdownContainer.classList.contains('show')) {
                setTimeout(() => {
                    const closeOnClickOutside = function(event) {
                        if (!dropdownContainer.contains(event.target)) {
                            dropdownContainer.classList.remove('show');
                            document.removeEventListener('click', closeOnClickOutside);
                        }
                    };
                    document.addEventListener('click', closeOnClickOutside);
                }, 0);
            }
        });

        // Prevent dropdown from closing when clicking inside it
        dropdownMenu.addEventListener('click', function(e) {
            // Only prevent propagation if not clicking on a link
            if (!e.target.closest('a')) {
                e.stopPropagation();
            }
        });
    }

    // Improved click-outside handler with capture phase to ensure it runs first
    document.addEventListener('click', function(e) {
        const dropdownContainer = document.getElementById('profileDropdownContainer');
        // Check if dropdown exists and is open
        if (dropdownContainer && dropdownContainer.classList.contains('show')) {
            // Check if click is outside the dropdown
            if (!dropdownContainer.contains(e.target)) {
                dropdownContainer.classList.remove('show');
            }
        }
    }, true); // Use capture phase to ensure this runs before other click handlers

    // Handle ESC key to close dropdown
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const dropdownContainer = document.getElementById('profileDropdownContainer');
            if (dropdownContainer && dropdownContainer.classList.contains('show')) {
                dropdownContainer.classList.remove('show');
            }
        }
    });

    // Initialize on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initProfileDropdown);
    } else {
        initProfileDropdown();
    }

    // Also initialize on window load to catch any late DOM changes
    window.addEventListener('load', initProfileDropdown);

    // Reinitialize on any potential AJAX page updates
    const originalFetch = window.fetch;
    window.fetch = function() {
        return originalFetch.apply(this, arguments).then(function(response) {
            setTimeout(initProfileDropdown, 500); // Reinitialize after AJAX calls
            return response;
        });
    };
})();
