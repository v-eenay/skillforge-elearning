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

    // Get all course elements - handle both dashboard and courses page layouts
    const allCourses = Array.from(courseContainer.querySelectorAll('.course-item'));

    // Log for debugging
    console.log('Found ' + allCourses.length + ' course items');
    allCourses.forEach((course, index) => {
        console.log('Course ' + index + ' status: ' + course.dataset.status);
    });

    // Search functionality
    if (searchInput) {
        console.log('Search input found, adding event listener');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            console.log('Searching for: ' + searchTerm);
            filterCourses(allCourses, searchTerm, getCurrentFilter());
        });
    } else {
        console.log('Search input not found');
    }

    // Filter buttons
    if (filterButtons.length > 0) {
        console.log('Found ' + filterButtons.length + ' filter buttons');
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                console.log('Filter button clicked: ' + this.dataset.filter);

                // Handle different button styles based on page
                const isDashboard = window.location.href.includes('dashboard');

                // Remove active class from all buttons
                filterButtons.forEach(btn => {
                    btn.classList.remove('active');
                    if (isDashboard) {
                        btn.classList.remove('btn-primary');
                        btn.classList.add('btn-outline-secondary');
                    } else {
                        btn.classList.remove('btn-primary');
                        btn.classList.add('btn-outline-secondary');
                    }
                });

                // Add active class to clicked button
                this.classList.add('active');
                if (isDashboard) {
                    this.classList.add('btn-primary');
                    this.classList.remove('btn-outline-secondary');
                } else {
                    this.classList.add('btn-primary');
                    this.classList.remove('btn-outline-secondary');
                }

                // Filter courses
                const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
                filterCourses(allCourses, searchTerm, this.dataset.filter);
            });
        });
    } else {
        console.log('No filter buttons found');
    }

    // Sort options
    if (sortOptions.length > 0) {
        console.log('Found ' + sortOptions.length + ' sort options');
        sortOptions.forEach(option => {
            option.addEventListener('click', function(e) {
                e.preventDefault();
                console.log('Sort option clicked: ' + this.dataset.sort);

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
    } else {
        console.log('No sort options found');
    }
}

/**
 * Filter courses based on search term and filter type
 * @param {Array} courses - Array of course elements
 * @param {string} searchTerm - Search term to filter by
 * @param {string} filterType - Type of filter (all, published, draft)
 */
function filterCourses(courses, searchTerm, filterType) {
    console.log('Filtering courses with search term: "' + searchTerm + '" and filter: "' + filterType + '"');
    console.log('Number of courses to filter: ' + courses.length);

    // Check if we're on the dashboard page
    const isDashboard = window.location.href.includes('dashboard');
    console.log('Is dashboard page: ' + isDashboard);

    courses.forEach((course, index) => {
        // Get course data
        let title = '';
        let category = '';
        const status = course.dataset.status ? course.dataset.status.toLowerCase() : '';
        console.log('Course ' + index + ' status: ' + status);

        // Handle different DOM structures
        if (isDashboard) {
            // Dashboard view - find title in h5 > a
            const titleH5 = course.querySelector('h5 a');
            if (titleH5) {
                title = titleH5.textContent.toLowerCase().trim();
                console.log('Course ' + index + ' title: ' + title);
            } else {
                console.log('Course ' + index + ' title element not found');
            }

            // Find category in small elements
            const smallElements = course.querySelectorAll('small');
            smallElements.forEach(small => {
                if (small.textContent.includes('Category:')) {
                    category = small.textContent.toLowerCase().trim();
                    console.log('Course ' + index + ' category: ' + category);
                }
            });
            if (!category) {
                console.log('Course ' + index + ' category not found');
            }
        } else {
            // Courses page view
            const titleElement = course.querySelector('.course-title');
            if (titleElement) {
                title = titleElement.textContent.toLowerCase().trim();
                console.log('Course ' + index + ' title: ' + title);
            } else {
                console.log('Course ' + index + ' title element not found');
            }

            const categoryElement = course.querySelector('.course-category');
            if (categoryElement) {
                category = categoryElement.textContent.toLowerCase().trim();
                console.log('Course ' + index + ' category: ' + category);
            } else {
                console.log('Course ' + index + ' category element not found');
            }
        }

        // Check if course matches search term
        const matchesSearch = searchTerm === '' ||
                             title.includes(searchTerm) ||
                             category.includes(searchTerm);

        // Check if course matches filter
        const matchesFilter = filterType === 'all' ||
                             (filterType === 'published' && status === 'active') ||
                             (filterType === 'draft' && (status === 'inactive' || status === 'draft'));

        console.log('Course ' + index + ' matches search: ' + matchesSearch + ', matches filter: ' + matchesFilter);

        // Show or hide course
        if (matchesSearch && matchesFilter) {
            course.style.display = '';
            console.log('Course ' + index + ' is visible');
        } else {
            course.style.display = 'none';
            console.log('Course ' + index + ' is hidden');
        }
    });

    // Show or hide the "no results" message
    const noResults = document.getElementById('noResults');
    if (noResults) {
        const visibleCourses = courses.filter(course => course.style.display !== 'none');
        console.log('Visible courses after filtering: ' + visibleCourses.length);
        noResults.style.display = visibleCourses.length === 0 ? 'block' : 'none';
    } else {
        console.log('No results element not found');
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
                const titleA = getTitleText(a);
                const titleB = getTitleText(b);
                return titleA.localeCompare(titleB);
            case 'za':
                const titleC = getTitleText(a);
                const titleD = getTitleText(b);
                return titleD.localeCompare(titleC);
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
 * Helper function to get the title text from a course element
 * @param {Element} courseElement - The course element
 * @returns {string} The title text
 */
function getTitleText(courseElement) {
    // Check if we're on the dashboard page
    const isDashboard = window.location.href.includes('dashboard');

    if (isDashboard) {
        // Dashboard view - find title in h5 > a
        const titleH5 = courseElement.querySelector('h5 a');
        if (titleH5) {
            return titleH5.textContent.trim();
        }
    } else {
        // Courses page view - find title in course-title class
        const titleElement = courseElement.querySelector('.course-title');
        if (titleElement) {
            return titleElement.textContent.trim();
        }

        // Fallback to h5 > a if course-title not found
        const titleH5 = courseElement.querySelector('h5 a');
        if (titleH5) {
            return titleH5.textContent.trim();
        }
    }

    // Fallback
    return '';
}

/**
 * Get the current active filter
 * @returns {string} Current filter (all, published, draft)
 */
function getCurrentFilter() {
    const activeFilter = document.querySelector('.filter-btn.active');
    return activeFilter ? activeFilter.dataset.filter : 'all';
}
