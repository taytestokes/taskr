const themeToggleDarkIcon = document.getElementById("theme-toggle-dark-icon");
const themeToggleLightIcon = document.getElementById("theme-toggle-light-icon");
const themeToggleBtn = document.getElementById("theme-toggle");

if (localStorage.getItem("theme") === "dark") {
  document.documentElement.classList.add("dark");
} else {
  document.documentElement.classList.remove("dark");
}

// Removes the hidden class added by default to show the icon
// that should be present depending on the current theme
if (localStorage.getItem("theme") === "dark") {
  themeToggleLightIcon.classList.remove("hidden");
} else {
  themeToggleDarkIcon.classList.remove("hidden");
}

themeToggleBtn.addEventListener("click", function () {
  // Toggle the icons to show correct one depending on theme
  themeToggleDarkIcon.classList.toggle("hidden");
  themeToggleLightIcon.classList.toggle("hidden");

  // If theme has previously been set to local storage
  if (localStorage.getItem("theme")) {
    if (localStorage.getItem("theme") === "light") {
      document.documentElement.classList.add("dark");
      localStorage.setItem("theme", "dark");
    } else {
      document.documentElement.classList.remove("dark");
      localStorage.setItem("theme", "light");
    }
    // If theme has not been set to local storage yet
  } else {
    if (document.documentElement.classList.contains("dark")) {
      document.documentElement.classList.remove("dark");
      localStorage.setItem("theme", "light");
    } else {
      document.documentElement.classList.add("dark");
      localStorage.setItem("theme", "dark");
    }
  }
});
