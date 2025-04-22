/**
 * SkillForge Instructor JavaScript
 * Handles sorting, filtering, and searching functionality for instructor pages
 */

document.addEventListener('DOMContentLoaded', function() {
    console.log('Instructor JS loaded');

    // Initialize dashboard functionality
    initDashboard();

    // Initialize courses page functionality
    initCoursesPage();
});

/**
 * Initialize dashboard functionality
 */
function initDashboard() {
    // Check if we're on the dashboard page
    if (!window.location.href.includes('dashboard')) return;
    console.log('Initializing dashboard functionality');

    const courseContainer = document.getElementById('coursesContainer');
    const searchInput = document.getElementById('searchCourses');
    const filterButtons = document.querySelectorAll('.filter-btn');

    // If course container doesn't exist, exit early
    if (!courseContainer) {
        console.log('Course container not found on dashboard');
        return;
    }

    // Get all course items
    const allCourses = Array.from(courseContainer.querySelectorAll('.course-item'));
    console.log(`Found ${allCourses.length} courses on dashboard`);

    // Add event listener to search input
    if (searchInput) {
        console.log('Search input found on dashboard');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            console.log(`Searching dashboard courses for: "${searchTerm}"`);
            filterDashboardCourses(allCourses, searchTerm, getCurrentDashboardFilter());
        });
    }

    // Add event listeners to filter buttons
    if (filterButtons.length > 0) {
        console.log(`Found ${filterButtons.length} filter buttons on dashboard`);
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                const filterType = this.dataset.filter;
                console.log(`Dashboard filter clicked: ${filterType}`);

                // Update button styles
                filterButtons.forEach(btn => {
                    btn.classList.remove('active', 'btn-primary');
                    btn.classList.add('btn-outline-secondary');
                });

                this.classList.add('active', 'btn-primary');
                this.classList.remove('btn-outline-secondary');

                // Filter courses
                const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
                filterDashboardCourses(allCourses, searchTerm, filterType);
            });
        });
    }

    // Initial filter (apply the active filter)
    const activeFilter = getCurrentDashboardFilter();
    console.log(`Initial dashboard filter: ${activeFilter}`);
    filterDashboardCourses(allCourses, searchInput ? searchInput.value.toLowerCase().trim() : '', activeFilter);
}

/**
 * Initialize courses page functionality
 */
function initCoursesPage() {
    // Check if we're on the courses page
    if (!window.location.href.includes('courses') || window.location.href.includes('dashboard')) return;
    console.log('Initializing courses page functionality');

    const courseContainer = document.getElementById('coursesContainer');
    const searchInput = document.getElementById('searchCourses');
    const filterButtons = document.querySelectorAll('.filter-btn');
    const sortOptions = document.querySelectorAll('.sort-option');

    // If course container doesn't exist, exit early
    if (!courseContainer) {
        console.log('Course container not found on courses page');
        return;
    }

    // Get all course items - include the create course card as well
    const allCourseItems = Array.from(courseContainer.querySelectorAll('.col-md-4'));
    // Filter out the create course card for filtering purposes
    const allCourses = allCourseItems.filter(item => item.classList.contains('course-item'));
    console.log(`Found ${allCourses.length} courses on courses page`);

    // Add event listener to search input
    if (searchInput) {
        console.log('Search input found on courses page');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            console.log(`Searching courses for: "${searchTerm}"`);
            filterCoursesPageCourses(allCourses, searchTerm, getCurrentCoursesPageFilter());
        });
    }

    // Add event listeners to filter buttons
    if (filterButtons.length > 0) {
        console.log(`Found ${filterButtons.length} filter buttons on courses page`);
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                const filterType = this.dataset.filter;
                console.log(`Courses page filter clicked: ${filterType}`);

                // Update button styles
                filterButtons.forEach(btn => {
                    btn.classList.remove('active', 'btn-primary');
                    btn.classList.add('btn-outline-secondary');
                });

                this.classList.add('active', 'btn-primary');
                this.classList.remove('btn-outline-secondary');

                // Filter courses
                const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
                filterCoursesPageCourses(allCourses, searchTerm, filterType);
            });
        });
    }

    // Add event listeners to sort options
    if (sortOptions.length > 0) {
        console.log(`Found ${sortOptions.length} sort options on courses page`);
        sortOptions.forEach(option => {
            option.addEventListener('click', function(e) {
                e.preventDefault();
                const sortType = this.dataset.sort;
                console.log(`Courses page sort clicked: ${sortType}`);

                // Update dropdown button text
                const sortDropdown = document.getElementById('sortDropdown');
                if (sortDropdown) {
                    sortDropdown.textContent = this.textContent;
                }

                // Sort courses
                sortCourses(allCourses, sortType);

                // Apply current filter and search
                const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : '';
                filterCoursesPageCourses(allCourses, searchTerm, getCurrentCoursesPageFilter());
            });
        });
    }

    // Initial filter (apply the active filter)
    const activeFilter = getCurrentCoursesPageFilter();
    console.log(`Initial courses page filter: ${activeFilter}`);
    filterCoursesPageCourses(allCourses, searchInput ? searchInput.value.toLowerCase().trim() : '', activeFilter);
}

/**
 * Filter courses on the dashboard
 * @param {Array} courses - Array of course elements
 * @param {string} searchTerm - Search term to filter by
 * @param {string} filterType - Type of filter (all, published, draft)
 */
function filterDashboardCourses(courses, searchTerm, filterType) {
    console.log(`Filtering dashboard courses with search: "${searchTerm}", filter: "${filterType}"`);

    courses.forEach((course, index) => {
        // Get course data
        const titleElement = course.querySelector('h5 a');
        const title = titleElement ? titleElement.textContent.toLowerCase().trim() : '';

        // Get category from small elements
        let category = '';
        const smallElements = course.querySelectorAll('small');
        smallElements.forEach(small => {
            if (small.textContent.includes('Category:')) {
                category = small.textContent.toLowerCase().trim();
            }
        });

        // Get status from dataset or badge
        let status = course.dataset.status ? course.dataset.status.toLowerCase() : '';
        if (!status) {
            const badge = course.querySelector('.badge');
            if (badge) {
                status = badge.textContent.toLowerCase().trim() === 'published' ? 'active' : 'inactive';
            }
        }

        console.log(`Dashboard course ${index}: title="${title}", category="${category}", status="${status}"`);

        // Check if course matches search term
        const matchesSearch = searchTerm === '' ||
                             title.includes(searchTerm) ||
                             category.includes(searchTerm);

        // Check if course matches filter
        const matchesFilter = filterType === 'all' ||
                             (filterType === 'published' && (status === 'active' || status.includes('published'))) ||
                             (filterType === 'draft' && (status === 'inactive' || status === 'draft' || status.includes('draft')));

        console.log(`Dashboard course ${index}: matchesSearch=${matchesSearch}, matchesFilter=${matchesFilter}`);

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
 * Filter courses on the courses page
 * @param {Array} courses - Array of course elements
 * @param {string} searchTerm - Search term to filter by
 * @param {string} filterType - Type of filter (all, published, draft)
 */
function filterCoursesPageCourses(courses, searchTerm, filterType) {
    console.log(`Filtering courses page with search: "${searchTerm}", filter: "${filterType}"`);

    courses.forEach((course, index) => {
        // Get course data
        const titleElement = course.querySelector('.course-title');
        const title = titleElement ? titleElement.textContent.toLowerCase().trim() : '';

        const categoryElement = course.querySelector('.course-category');
        const category = categoryElement ? categoryElement.textContent.toLowerCase().trim() : '';

        // Get status from dataset or status span
        let status = course.dataset.status ? course.dataset.status.toLowerCase() : '';
        if (!status) {
            const statusSpan = course.querySelector('.course-status');
            if (statusSpan) {
                if (statusSpan.classList.contains('status-active')) {
                    status = 'active';
                } else if (statusSpan.classList.contains('status-inactive')) {
                    status = 'inactive';
                } else if (statusSpan.classList.contains('status-draft')) {
                    status = 'draft';
                }
            }
        }

        console.log(`Courses page course ${index}: title="${title}", category="${category}", status="${status}"`);

        // Check if course matches search term
        const matchesSearch = searchTerm === '' ||
                             title.includes(searchTerm) ||
                             category.includes(searchTerm);

        // Check if course matches filter
        const matchesFilter = filterType === 'all' ||
                             (filterType === 'published' && (status === 'active' || status.includes('published'))) ||
                             (filterType === 'draft' && (status === 'inactive' || status === 'draft' || status.includes('draft')));

        console.log(`Courses page course ${index}: matchesSearch=${matchesSearch}, matchesFilter=${matchesFilter}`);

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
    console.log(`Sorting courses by: ${sortType}`);

    const sortedCourses = [...courses].sort((a, b) => {
        switch (sortType) {
            case 'newest':
                return new Date(b.dataset.created) - new Date(a.dataset.created);
            case 'oldest':
                return new Date(a.dataset.created) - new Date(b.dataset.created);
            case 'az':
                const titleA = getCourseTitleText(a);
                const titleB = getCourseTitleText(b);
                return titleA.localeCompare(titleB);
            case 'za':
                const titleC = getCourseTitleText(a);
                const titleD = getCourseTitleText(b);
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
 * Get the title text from a course element
 * @param {Element} courseElement - The course element
 * @returns {string} The title text
 */
function getCourseTitleText(courseElement) {
    // Try to get title from course-title class
    const titleElement = courseElement.querySelector('.course-title');
    if (titleElement) {
        return titleElement.textContent.trim();
    }

    // Try to get title from h5 > a (dashboard view)
    const titleH5 = courseElement.querySelector('h5 a');
    if (titleH5) {
        return titleH5.textContent.trim();
    }

    // Fallback
    return '';
}

/**
 * Get the current active filter on the dashboard
 * @returns {string} Current filter (all, published, draft)
 */
function getCurrentDashboardFilter() {
    const activeFilter = document.querySelector('.filter-btn.active');
    return activeFilter ? activeFilter.dataset.filter : 'all';
}

/**
 * Get the current active filter on the courses page
 * @returns {string} Current filter (all, published, draft)
 */
function getCurrentCoursesPageFilter() {
    const activeFilter = document.querySelector('.filter-btn.active');
    return activeFilter ? activeFilter.dataset.filter : 'all';
}
