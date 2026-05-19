<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="isEdit" value="${formMode eq 'edit'}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${isEdit ? 'Edit' : 'Add'} Destination - Admin | Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="../_nav.jsp">
    <jsp:param name="activePage" value=""/>
  </jsp:include>

  <div class="admin-wrapper">

    <jsp:include page="_sidebar.jsp">
      <jsp:param name="activePage" value="${isEdit ? 'destinations' : 'destination-form'}"/>
    </jsp:include>

    <main class="admin-content">

      <div class="page-header" style="margin-bottom:var(--sp-4);">
        <div>
          <h1>${isEdit ? 'Edit Destination' : 'Add New Destination'}</h1>
          <p>
            <c:choose>
              <c:when test="${isEdit}">
                Update the details for <strong><c:out value="${destination.name}"/></strong>.
              </c:when>
              <c:otherwise>
                Fill in the details below to add a new destination to the platform.
              </c:otherwise>
            </c:choose>
          </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary btn-sm">
          Back to List
        </a>
      </div>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <div style="background:#fff; border-radius:var(--radius-lg); border:1px solid var(--color-outline-variant); padding:var(--sp-4); box-shadow:var(--shadow-card); max-width:760px;">

        <form action="${pageContext.request.contextPath}/admin/destination-form"
              method="post"
              style="display:flex; flex-direction:column; gap:var(--sp-3);">

          <c:if test="${isEdit}">
            <input type="hidden" name="id" value="${destination.id}"/>
          </c:if>

          <div class="grid-2" style="gap:var(--sp-2);">
            <div class="form-group">
              <label class="form-label" for="name">Destination Name <span style="color:var(--color-error);">*</span></label>
              <input class="form-input" type="text" id="name" name="name"
                     value="${fn:escapeXml(destination.name)}"
                     placeholder="e.g. Everest Base Camp"
                     maxlength="150"
                     required/>
            </div>
            <div class="form-group">
              <label class="form-label" for="location">Location <span style="color:var(--color-error);">*</span></label>
              <input class="form-input" type="text" id="location" name="location"
                     value="${fn:escapeXml(destination.location)}"
                     placeholder="e.g. Solukhumbu District"
                     maxlength="150"
                     required/>
            </div>
          </div>

          <div class="grid-2" style="gap:var(--sp-2);">
            <div class="form-group">
              <label class="form-label" for="region">Region <span style="color:var(--color-error);">*</span></label>
              <select class="form-select" id="region" name="region" required>
                <option value="">Select region</option>
                <c:forEach var="region" items="${regionOptions}">
                  <c:choose>
                    <c:when test="${destination.region eq region}">
                      <option value="${fn:escapeXml(region)}" selected="selected"><c:out value="${region}"/></option>
                    </c:when>
                    <c:otherwise>
                      <option value="${fn:escapeXml(region)}"><c:out value="${region}"/></option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label" for="category">Category <span style="color:var(--color-error);">*</span></label>
              <select class="form-select" id="category" name="category" required>
                <option value="">Select category</option>
                <c:forEach var="cat" items="${categoryOptions}">
                  <c:choose>
                    <c:when test="${destination.category eq cat}">
                      <option value="${fn:escapeXml(cat)}" selected="selected"><c:out value="${cat}"/></option>
                    </c:when>
                    <c:otherwise>
                      <option value="${fn:escapeXml(cat)}"><c:out value="${cat}"/></option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </div>
          </div>

          <div class="grid-2" style="gap:var(--sp-2);">
            <div class="form-group">
              <label class="form-label" for="difficulty">Difficulty <span style="color:var(--color-error);">*</span></label>
              <select class="form-select" id="difficulty" name="difficulty" required>
                <option value="">Select difficulty</option>
                <c:forEach var="diff" items="${difficultyOptions}">
                  <c:choose>
                    <c:when test="${destination.difficulty eq diff}">
                      <option value="${fn:escapeXml(diff)}" selected="selected"><c:out value="${diff}"/></option>
                    </c:when>
                    <c:otherwise>
                      <option value="${fn:escapeXml(diff)}"><c:out value="${diff}"/></option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label" for="durationDays">Duration (days) <span style="color:var(--color-error);">*</span></label>
              <input class="form-input" type="number" id="durationDays" name="durationDays"
                     value="${destination.durationDays gt 0 ? destination.durationDays : ''}"
                     placeholder="e.g. 14"
                     min="1" max="365" required/>
            </div>
          </div>

          <div class="grid-2" style="gap:var(--sp-2);">
            <div class="form-group">
              <label class="form-label" for="price">Price (USD) <span style="color:var(--color-error);">*</span></label>
              <input class="form-input" type="number" id="price" name="price"
                     value="${not empty destination.price ? destination.price : ''}"
                     placeholder="e.g. 1299"
                     min="0" step="0.01" required/>
            </div>
            <div class="form-group">
              <label class="form-label" for="imageUrl">Image URL <span style="color:var(--color-slate-gray); font-weight:400; text-transform:none; letter-spacing:0;">(optional)</span></label>
              <input class="form-input" type="url" id="imageUrl" name="imageUrl"
                     value="${fn:escapeXml(destination.imageUrl)}"
                     placeholder="https://example.com/image.jpg"
                     maxlength="500"/>
              <c:if test="${not empty destination.imageUrl}">
                <div id="previewWrap" class="image-preview">
                  <img id="imgPreview" src="${fn:escapeXml(destination.imageUrl)}" alt="Destination image preview"/>
                </div>
              </c:if>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="description">Description <span style="color:var(--color-error);">*</span></label>
            <textarea class="form-textarea" id="description" name="description"
                      placeholder="Provide a compelling description of this destination"
                      required><c:out value="${destination.description}"/></textarea>
          </div>

          <div style="display:flex; gap:var(--sp-2); padding-top:var(--sp-2); border-top:1px solid var(--color-outline-variant);">
            <button type="submit" class="btn btn-primary">
              ${isEdit ? 'Save Changes' : 'Add Destination'}
            </button>
            <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary">
              Cancel
            </a>
          </div>

        </form>
      </div>

    </main>
  </div>

</body>
</html>
