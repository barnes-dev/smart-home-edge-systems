/**
 * THE ASYNCHRONOUS COMPONENT INGESTION ENGINE
 */
function loadComponent(elementId, filePath, callback = null) {
  fetch(filePath)
    .then(response => {
      if (!response.ok) throw new Error(`Failed to load ${filePath}`);
      return response.text();
    })
    .then(data => {
      const container = document.getElementById(elementId);
      if (container) {
        container.innerHTML = data;
      }
      if (callback) callback();
    })
    .catch(error => console.error(error));
}

/**
 * THE ASSEMBLY PIPELINE EXECUTION
 */
document.addEventListener("DOMContentLoaded", () => {
  // Ingest your global logo and header asset blocks
  loadComponent("header-placeholder", "/includes/header.html");
  
  // Ingest your standardized footer copyright block
  loadComponent("footer-placeholder", "/includes/footer.html");
});