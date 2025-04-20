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

        // Force the dropdown container to have a higher stacking context
        dropdownContainer.style.position = 'relative';
        dropdownContainer.style.zIndex = '99999';

        // Ensure the dropdown menu has the highest z-index
        dropdownMenu.style.zIndex = '100000';

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

            // Force a repaint to ensure the dropdown is visible
            dropdownMenu.style.display = 'none';
            setTimeout(function() {
                if (dropdownContainer.classList.contains('show')) {
                    dropdownMenu.style.display = 'block';
                }
            }, 0);
        });

        // Prevent dropdown from closing when clicking inside it
        dropdownMenu.addEventListener('click', function(e) {
            // Only prevent propagation if not clicking on a link
            if (!e.target.closest('a')) {
                e.stopPropagation();
            }
        });
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        const dropdownContainer = document.getElementById('profileDropdownContainer');
        if (dropdownContainer && !dropdownContainer.contains(e.target)) {
            dropdownContainer.classList.remove('show');
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
