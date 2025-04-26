<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<!-- Modern Hero Section -->
<section class="courses-hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <h1>Explore Our Courses</h1>
                <p>Discover a wide range of courses designed to help you master new skills, advance your career, and achieve your goals.</p>
                <%-- Modern Search Form --%>
                <div class="search-filter-container">
                    <form action="${pageContext.request.contextPath}/courses" method="get" class="input-group">
                        <input type="hidden" name="category" value="${categoryId}">
                        <input type="hidden" name="sort" value="${sortBy}">
                        <input type="text" name="search" class="form-control" placeholder="Search courses..." aria-label="Search courses" value="${searchTerm}">
                        <button class="btn" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
            </div>
            <div class="col-lg-6 text-center">
                <img src="${pageContext.request.contextPath}/assets/images/courses_hero.svg" alt="SkillForge Courses" class="img-fluid rounded-4 hero-image" style="max-height: 400px; object-fit: contain;">
            </div>
        </div>
    </div>
</section>

<!-- Modern Category Tabs -->
<section class="course-categories">
    <div class="container">
        <nav class="nav nav-pills">
            <li class="nav-item">
                <a class="nav-link ${categoryId == 0 ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?search=${searchTerm}&sort=${sortBy}">All Categories</a>
            </li>
            <c:forEach var="category" items="${categories}">
                <li class="nav-item">
                    <a class="nav-link ${categoryId == category.categoryId ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?category=${category.categoryId}&search=${searchTerm}&sort=${sortBy}">${category.name}</a>
                </li>
            </c:forEach>
        </nav> <%-- Changed ul to nav --%>
    </div>
</section>

<!-- Modern Courses List -->
<section class="all-courses">
    <div class="container">
        <div class="section-header">
            <h2>
                <c:choose>
                    <c:when test="${not empty selectedCategory}">
                        ${selectedCategory.name} Courses (${totalCourses})
                    </c:when>
                    <c:when test="${not empty searchTerm}">
                        Search Results for "${searchTerm}" (${totalCourses})
                    </c:when>
                    <c:otherwise>
                        All Courses (${totalCourses})
                    </c:otherwise>
                </c:choose>
            </h2>
            <div class="dropdown sort-dropdown">
                <button class="btn dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    Sort by:
                    <c:choose>
                        <c:when test="${sortBy == 'newest'}">Newest</c:when>
                        <c:when test="${sortBy == 'oldest'}">Oldest</c:when>
                        <c:when test="${sortBy == 'az'}">A-Z</c:when>
                        <c:when test="${sortBy == 'za'}">Z-A</c:when>
                        <c:when test="${sortBy == 'popular'}">Popular</c:when> <%-- Add logic if implemented --%>
                        <c:otherwise>Newest</c:otherwise>
                    </c:choose>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="sortDropdown">
                    <li><a class="dropdown-item ${sortBy == 'newest' ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=newest&page=${currentPage}">Newest</a></li>
                    <li><a class="dropdown-item ${sortBy == 'oldest' ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=oldest&page=${currentPage}">Oldest</a></li>
                    <li><a class="dropdown-item ${sortBy == 'az' ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=az&page=${currentPage}">A-Z</a></li>
                    <li><a class="dropdown-item ${sortBy == 'za' ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=za&page=${currentPage}">Z-A</a></li>
                    <%-- Add Popularity sort option if implemented --%>
                    <%-- <li><a class="dropdown-item ${sortBy == 'popular' ? 'active' : ''}" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=popular&page=${currentPage}">Popular</a></li> --%>
                </ul>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty courses}">
                <div class="row g-4">
                    <c:forEach var="course" items="${courses}">
                        <div class="col-md-6 col-lg-4 d-flex align-items-stretch">
                            <div class="card course-card">
                                <div class="position-relative">
                                    <a href="${pageContext.request.contextPath}/courses/view?id=${course.courseId}">
                                        <c:choose>
                                                <c:when test="${not empty course.thumbnail}">
                                                    <%-- Assuming thumbnail path starts with '/' or is relative to context root --%>
                                                    <c:set var="imageUrl" value="${pageContext.request.contextPath}${course.thumbnail.startsWith('/') ? '' : '/'}${course.thumbnail}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <%-- Use default course thumbnail --%>
                                                    <c:set var="imageUrl" value="${pageContext.request.contextPath}/assets/images/course-thumbnail.svg"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <img src="${imageUrl}"
                                                 class="card-img-top" alt="${course.title}"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/course-thumbnail.svg';">
                                    </a>
                                    <%-- Add badges if needed, e.g., Bestseller, New --%>
                                    <%-- <span class="badge bg-primary position-absolute top-0 end-0 m-3">Bestseller</span> --%>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <span class="course-category">${course.category.name}</span>
                                    <%-- Add rating if available later in course-meta --%>
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/courses/view?id=${course.courseId}" class="text-decoration-none text-dark stretched-link">${course.title}</a>
                                    </h5>
                                    <p class="text-muted small mb-3 flex-grow-1">${course.description.length() > 100 ? course.description.substring(0, 100).concat('...') : course.description}</p>
                                    <div class="instructor-info mt-auto pt-3 border-top"> <%-- Removed d-flex, align-items, mb-3 --%>
                                        <c:choose>
                                            <c:when test="${not empty course.creator.profileImage}">
                                                <c:set var="creatorImageUrl" value="${pageContext.request.contextPath}${course.creator.profileImage.startsWith('/') ? '' : '/'}${course.creator.profileImage}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="creatorImageUrl" value="${pageContext.request.contextPath}/assets/images/default-profile.svg"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <img src="${creatorImageUrl}"
                                             class="rounded-circle" alt="${course.creator.name}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                                        <span>${course.creator.name}</span>
                                    </div>
                                    <div class="course-meta">
                                        <%-- Placeholder for Rating --%>
                                        <div class="rating">
                                            <%-- <i class="fas fa-star"></i> 4.5 <span class="rating-count">(120)</span> --%>
                                            <span class="text-capitalize">${course.level}</span> <%-- Moved level here --%>
                                        </div>
                                        <%-- Placeholder for Price --%>
                                        <div class="price">
                                            <%-- $49.99 <span class="original-price">$99.99</span> --%>
                                            <%-- Display 'Free' or price based on course data if available --%>
                                            Free <%-- Default to Free if no price logic --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <p class="lead">No courses found matching your criteria.</p>
                    <c:if test="${categoryId != 0 || not empty searchTerm}">
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary mt-3">View All Courses</a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Modern Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Course pagination" class="courses-pagination">
                <ul class="pagination">
                    <%-- Previous Page --%>
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=${sortBy}&page=${currentPage - 1}" tabindex="-1" aria-disabled="${currentPage == 1}">Previous</a>
                    </li>

                    <%-- Page Numbers --%>
                    <%-- Determine pagination range --%>
                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                    <c:set var="endPage" value="${startPage + 4 < totalPages ? startPage + 4 : totalPages}"/>
                    <c:if test="${endPage - startPage < 4 && totalPages > 4}">
                        <c:set var="startPage" value="${totalPages - 4 > 0 ? totalPages - 4 : 1}"/>
                    </c:if>

                    <%-- Ellipsis at the beginning --%>
                    <c:if test="${startPage > 1}">
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=${sortBy}&page=1">1</a></li>
                        <c:if test="${startPage > 2}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>
                    </c:if>

                    <%-- Actual page numbers --%>
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}" ${currentPage == i ? 'aria-current="page"' : ''}>
                            <a class="page-link" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=${sortBy}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <%-- Ellipsis at the end --%>
                    <c:if test="${endPage < totalPages}">
                        <c:if test="${endPage < totalPages - 1}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>
                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=${sortBy}&page=${totalPages}">${totalPages}</a></li>
                    </c:if>

                    <%-- Next Page --%>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/courses?category=${categoryId}&search=${searchTerm}&sort=${sortBy}&page=${currentPage + 1}" aria-disabled="${currentPage == totalPages}">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</section>

<%@ include file="/common/footer.jsp" %>
