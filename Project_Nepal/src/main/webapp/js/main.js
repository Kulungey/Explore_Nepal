(function () {
  'use strict';

  function ready(callback) {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', callback);
    } else {
      callback();
    }
  }

  function initNavigation() {
    var btn = document.getElementById('navToggle');
    var links = document.getElementById('navLinks');
    if (!btn || !links) return;

    btn.addEventListener('click', function () {
      var open = links.classList.toggle('nav-links--open');
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });

    links.querySelectorAll('a, button').forEach(function (el) {
      el.addEventListener('click', function () {
        links.classList.remove('nav-links--open');
        btn.setAttribute('aria-expanded', 'false');
      });
    });
  }

  function showError(input, error) {
    if (!input || !error) return;
    error.style.display = 'block';
    input.classList.add('error');
  }

  function clearError(input, error) {
    if (!input || !error) return;
    error.style.display = 'none';
    input.classList.remove('error');
  }

  function initRegisterValidation() {
    var form = document.getElementById('registerForm');
    if (!form) return;

    var fullName = document.getElementById('fullName');
    var emailInput = document.getElementById('email');
    var phone = document.getElementById('phone');
    var password = document.getElementById('password');
    var confirmPw = document.getElementById('confirmPassword');
    var nameError = document.getElementById('nameError');
    var emailError = document.getElementById('emailError');
    var phoneError = document.getElementById('phoneError');
    var pwStrengthError = document.getElementById('pwStrengthError');
    var pwMatchError = document.getElementById('pwMatchError');

    form.addEventListener('submit', function (event) {
      var valid = true;
      var fullNameValue = fullName.value.trim();
      var emailValue = emailInput.value.trim();
      var phoneValue = phone.value.trim();
      var passwordValue = password.value;
      var strongPassword = passwordValue.length >= 8 &&
        /[A-Z]/.test(passwordValue) &&
        /[0-9]/.test(passwordValue) &&
        /[!@#$%^&*()\-_=+\[\]{};':"\\|,.<>/?]/.test(passwordValue);

      if (!/^[a-zA-Z\s.'\-]+$/.test(fullNameValue)) {
        showError(fullName, nameError);
        valid = false;
      } else {
        clearError(fullName, nameError);
      }

      if (!/^[\w.+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/.test(emailValue)) {
        showError(emailInput, emailError);
        valid = false;
      } else {
        clearError(emailInput, emailError);
      }

      if (!/^9\d{9}$/.test(phoneValue)) {
        showError(phone, phoneError);
        valid = false;
      } else {
        clearError(phone, phoneError);
      }

      if (!strongPassword) {
        showError(password, pwStrengthError);
        valid = false;
      } else {
        clearError(password, pwStrengthError);
      }

      if (password.value !== confirmPw.value) {
        showError(confirmPw, pwMatchError);
        valid = false;
      } else {
        clearError(confirmPw, pwMatchError);
      }

      if (!valid) event.preventDefault();
    });
  }

  function initDestinationPreview() {
    var urlInput = document.getElementById('imageUrl');
    if (!urlInput) return;

    urlInput.addEventListener('change', function () {
      var value = urlInput.value.trim();
      var wrap = document.getElementById('previewWrap');
      var img = document.getElementById('imgPreview');

      if (!value) {
        if (wrap) wrap.remove();
        return;
      }

      if (!wrap) {
        wrap = document.createElement('div');
        wrap.id = 'previewWrap';
        wrap.className = 'image-preview';
        img = document.createElement('img');
        img.id = 'imgPreview';
        img.alt = 'Destination image preview';
        wrap.appendChild(img);
        urlInput.closest('.form-group').appendChild(wrap);
      }

      img.src = value;
      img.onerror = function () {
        wrap.remove();
      };
    });
  }

  function initDeleteConfirmation() {
    document.querySelectorAll('.js-delete-destination-form').forEach(function (form) {
      form.addEventListener('submit', function (event) {
        var name = form.dataset.destinationName || 'this destination';
        var confirmed = window.confirm('Delete "' + name + '"? This cannot be undone.');
        if (!confirmed) event.preventDefault();
      });
    });
  }

  ready(function () {
    initNavigation();
    initRegisterValidation();
    initDestinationPreview();
    initDeleteConfirmation();
  });
})();
