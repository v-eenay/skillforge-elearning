/**
 * SkillForge Instructor JavaScript
 * Handles sorting, filtering, and searching functionality for instructor pages
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize course filtering and sorting
    initCoursesFiltering();
});

/**
 * Initialize course filtering, sorting, and search functionality
 */
function initCoursesFiltering() {
    const courseContainer = document.getElementById('coursesContainer');
    const searchInput = document.getElementById('searchCourses');
    const filterButtons = document.querySelectorAll('.filter-btn');
    const sortOptions = document.querySelectorAll('.sort-option');
    
    // If we're not on a page with courses, exit early
    if (!courseContainer) return;
    
    // Get all course elements
    const allCourses = Array.from(courseContainer.querySelectorAll('.course-item'));
    
    // Search functionality
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            filterCourses(allCourses, searchTerm, getCurrentFilter());
        });
    }
    
    // Filter buttons
    if (filterButtons.length > 0) {
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                filterButtons.forEach(btn => btn.classList.remove('active', 'btn-primary'));
                filterButtons.forEach(btn => btn.classList.add('btn-outline-secondary'));
                
                // Add active class to clicked button
                this.classList.add('active', 'btn-primary');
                this.classList.remove('btn-outline-secondary');
                
                // Filter courses
                const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
                filterCourses(allCourses, searchTerm, this.dataset.filter);
            });
        });
    }
    
    // Sort options
    if (sortOptions.length > 0) {
        sortOptions.forEach(option => {
            option.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Update dropdown button text
                const sortDropdown = document.getElementById('sortDropdown');
                if (sortDropdown) {
                    sortDropdown.textContent = this.textContent;
                }
                
                // Sort courses
                sortCourses(allCourses, this.dataset.sort);
                
                // Apply current filter and search
                const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
                filterCourses(allCourses, searchTerm, getCurrentFilter());
            });
        });
    }
}

/**
 * Filter courses based on search term and filter type
 * @param {Array} courses - Array of course elements
 * @param {string} searchTerm - Search term to filter by
 * @param {string} filterType - Type of filter (all, published, draft)
 */
function filterCourses(courses, searchTerm, filterType) {
    courses.forEach(course => {
        // Get course data
        const title = course.querySelector('.course-title').textContent.toLowerCase();
        const category = course.querySelector('.course-category').textContent.toLowerCase();
        const status = course.dataset.status.toLowerCase();
        
        // Check if course matches search term
        const matchesSearch = searchTerm === '' || 
                             title.includes(searchTerm) || 
                             category.includes(searchTerm);
        
        // Check if course matches filter
        const matchesFilter = filterType === 'all' || 
                             (filterType === 'published' && status === 'active') ||
                             (filterType === 'draft' && status === 'inactive');
        
        // Show or hide course
        if (matchesSearch && matchesFilter) {
            course.style.display = '';
        } else {
            course.style.display = 'none';
        }
    });
    
    // Show or hide the "no results" message
    const noResults = document.getElementById('noResults');
    if (noResults) {
        const visibleCourses = courses.filter(course => course.style.display !== 'none');
        noResults.style.display = visibleCourses.length === 0 ? 'block' : 'none';
    }
}

/**
 * Sort courses based on sort type
 * @param {Array} courses - Array of course elements
 * @param {string} sortType - Type of sort (newest, oldest, az, za, students)
 */
function sortCourses(courses, sortType) {
    const sortedCourses = [...courses].sort((a, b) => {
        switch (sortType) {
            case 'newest':
                return new Date(b.dataset.created) - new Date(a.dataset.created);
            case 'oldest':
                return new Date(a.dataset.created) - new Date(b.dataset.created);
            case 'az':
                return a.querySelector('.course-title').textContent.localeCompare(b.querySelector('.course-title').textContent);
            case 'za':
                return b.querySelector('.course-title').textContent.localeCompare(a.querySelector('.course-title').textContent);
            case 'students':
                return parseInt(b.dataset.students || 0) - parseInt(a.dataset.students || 0);
            default:
                return 0;
        }
    });
    
    // Reorder courses in the DOM
    const container = courses[0].parentNode;
    sortedCourses.forEach(course => container.appendChild(course));
}

/**
 * Get the current active filter
 * @returns {string} Current filter (all, published, draft)
 */
function getCurrentFilter() {
    const activeFilter = document.querySelector('.filter-btn.active');
    return activeFilter ? activeFilter.dataset.filter : 'all';
}
