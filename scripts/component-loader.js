function loadComponent(elementId, filePath, callback) {
  fetch(filePath)
    .then(response => {
      if (!response.ok) {
        throw new Error(`Failed to load ${filePath}: ${response.status}`);
      }
      return response.text();
    })
    .then(data => {
      const element = document.getElementById(elementId);

      if (!element) {
        throw new Error(`Component placeholder not found: #${elementId}`);
      }

      element.innerHTML = data;

      if (typeof callback === "function") {
        callback();
      }
    })
    .catch(error => console.error(error));
}

function fixMenuPaths() {
  const pathSegments = window.location.pathname.split("/").filter(Boolean);
  let depth = pathSegments.length;

  if (pathSegments.length > 0 && pathSegments[pathSegments.length - 1].endsWith(".html")) {
    depth -= 1;
  }

  const rootPrefix = depth > 0 ? "../".repeat(depth) : "./";
  const currentSection = pathSegments[0] || "";
  const links = [
    ["nav-home", "index.html"],
    ["nav-guides", "guides/index.html"],
    ["nav-reference", "reference/index.html"],
    ["nav-gateway", "index.html"]
  ];

  links.forEach(([id, target]) => {
    const link = document.getElementById(id);

    if (!link) {
      return;
    }

    link.href = rootPrefix + target;

    const linkPath = new URL(link.href, window.location.origin).pathname;
    const linkSection = linkPath.split("/").filter(Boolean)[0] || "";

    if (linkSection === currentSection) {
      link.classList.add("active");
    }
  });
}

document.addEventListener("DOMContentLoaded", () => {
  loadComponent("header-placeholder", "/includes/header.html");
  loadComponent("menu-placeholder", "/includes/menu.html", fixMenuPaths);
  loadComponent("footer-placeholder", "/includes/footer.html");
});
