/* ============================================
   VKS WEDDING DECORATIONS — LUXURY JS
   Multi-page compatible — modular initialization
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {

  // ---------- PRELOADER ----------
  const preloader = document.getElementById('preloader');
  if (preloader) {
    window.addEventListener('load', () => {
      setTimeout(() => { preloader.classList.add('hidden'); }, 1200);
    });
    setTimeout(() => { preloader.classList.add('hidden'); }, 3500);
  }

  // ---------- HERO PARTICLES (reduced) ----------
  const particlesContainer = document.getElementById('heroParticles');
  if (particlesContainer) {
    for (let i = 0; i < 12; i++) {
      const particle = document.createElement('div');
      particle.classList.add('particle');
      particle.style.left = Math.random() * 100 + '%';
      particle.style.width = (Math.random() * 3 + 1) + 'px';
      particle.style.height = particle.style.width;
      particle.style.animationDelay = Math.random() * 8 + 's';
      particle.style.animationDuration = (Math.random() * 6 + 5) + 's';
      particle.style.opacity = Math.random() * 0.5 + 0.2;
      particlesContainer.appendChild(particle);
    }
  }

  // ---------- NAVBAR SCROLL ----------
  const navbar = document.getElementById('navbar');
  const backToTop = document.getElementById('backToTop');

  const handleScroll = () => {
    const scrollY = window.scrollY;
    if (navbar) {
      if (scrollY > 80) { navbar.classList.add('scrolled'); }
      else { navbar.classList.remove('scrolled'); }
    }
    if (backToTop) {
      if (scrollY > 600) { backToTop.classList.add('show'); }
      else { backToTop.classList.remove('show'); }
    }
  };

  window.addEventListener('scroll', handleScroll, { passive: true });

  if (backToTop) {
    backToTop.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // ---------- MOBILE MENU ----------
  const menuToggle = document.getElementById('menuToggle');
  const navLinks = document.getElementById('navLinks');

  if (menuToggle && navLinks) {
    menuToggle.addEventListener('click', () => {
      menuToggle.classList.toggle('active');
      navLinks.classList.toggle('active');
      document.body.style.overflow = navLinks.classList.contains('active') ? 'hidden' : '';
    });

    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        menuToggle.classList.remove('active');
        navLinks.classList.remove('active');
        document.body.style.overflow = '';
      });
    });
  }

  // ---------- SMOOTH SCROLL FOR ANCHOR LINKS ----------
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const targetId = this.getAttribute('href');
      if (targetId === '#') return;
      e.preventDefault();
      const targetEl = document.querySelector(targetId);
      if (targetEl) {
        const navHeight = navbar ? navbar.offsetHeight : 0;
        const targetPosition = targetEl.getBoundingClientRect().top + window.scrollY - navHeight;
        window.scrollTo({ top: targetPosition, behavior: 'smooth' });
      }
    });
  });

  // ---------- SCROLL REVEAL ANIMATIONS ----------
  const revealElements = document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .reveal-scale');

  if (revealElements.length > 0) {
    const revealObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('active');
          revealObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });

    revealElements.forEach(el => revealObserver.observe(el));
  }

  // ---------- COUNTER ANIMATION ----------
  const counters = document.querySelectorAll('.stat-number[data-count]');

  if (counters.length > 0) {
    const counterObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const el = entry.target;
          const target = parseInt(el.getAttribute('data-count'));
          animateCounter(el, target);
          counterObserver.unobserve(el);
        }
      });
    }, { threshold: 0.5 });

    counters.forEach(counter => counterObserver.observe(counter));
  }

  function animateCounter(el, target) {
    let current = 0;
    const increment = target / 60;
    const stepTime = 2000 / 60;
    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        current = target;
        clearInterval(timer);
      }
      el.textContent = Math.floor(current) + '+';
    }, stepTime);
  }

  // ---------- GALLERY FILTER ----------
  const filterBtns = document.querySelectorAll('.gallery-filter-btn');
  const galleryItems = document.querySelectorAll('.gallery-item');

  if (filterBtns.length > 0 && galleryItems.length > 0) {
    filterBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        filterBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const filter = btn.getAttribute('data-filter');
        galleryItems.forEach((item, index) => {
          const category = item.getAttribute('data-category');
          if (filter === 'all' || category === filter) {
            item.style.transition = `opacity 0.4s ease ${index * 0.05}s, transform 0.4s ease ${index * 0.05}s`;
            item.style.opacity = '1';
            item.style.transform = 'scale(1)';
            item.style.display = '';
          } else {
            item.style.opacity = '0';
            item.style.transform = 'scale(0.9)';
            setTimeout(() => { item.style.display = 'none'; }, 400);
          }
        });
      });
    });
  }

  // ---------- LIGHTBOX ----------
  const lightbox = document.getElementById('lightbox');
  const lightboxImage = document.getElementById('lightboxImage');
  const lightboxClose = document.getElementById('lightboxClose');

  if (lightbox && lightboxImage) {
    galleryItems.forEach(item => {
      item.addEventListener('click', () => {
        const imgSrc = item.querySelector('img').src;
        lightboxImage.src = imgSrc;
        lightbox.classList.add('active');
        document.body.style.overflow = 'hidden';
      });
    });

    if (lightboxClose) lightboxClose.addEventListener('click', closeLightbox);
    lightbox.addEventListener('click', (e) => { if (e.target === lightbox) closeLightbox(); });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && lightbox.classList.contains('active')) closeLightbox();
    });
  }

  function closeLightbox() {
    if (!lightbox) return;
    lightbox.classList.remove('active');
    document.body.style.overflow = '';
    setTimeout(() => { if (lightboxImage) lightboxImage.src = ''; }, 400);
  }

  // ---------- FORM SUBMISSION (WhatsApp) ----------
  const leadForm = document.getElementById('leadForm');
  const submitBtn = document.getElementById('submitBtn');

  if (leadForm && submitBtn) {
    leadForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const formData = new FormData(leadForm);
      const name = formData.get('name');
      const date = formData.get('wedding_date');
      const phone = formData.get('phone');
      const venue = formData.get('venue') || 'Not decided';
      const budget = formData.get('budget');

      const message = `Hello, I would like to check date availability.\n\nName: ${name}\nEvent Date: ${date}\nVenue: ${venue}\nBudget: ${budget}\nPhone: ${phone}\n\nPlease confirm availability.`;

      const whatsappUrl = `https://wa.me/919789567567?text=${encodeURIComponent(message)}`;

      submitBtn.textContent = 'Redirecting to WhatsApp...';
      submitBtn.style.pointerEvents = 'none';

      setTimeout(() => {
        window.open(whatsappUrl, '_blank');
        submitBtn.textContent = 'Check Date Availability';
        submitBtn.style.pointerEvents = '';
        leadForm.reset();
      }, 800);
    });
  }

  // ---------- FORM INPUT ANIMATIONS ----------
  document.querySelectorAll('.form-group input, .form-group select, .form-group textarea').forEach(input => {
    input.addEventListener('focus', () => {
      input.parentElement.style.transform = 'translateY(-2px)';
      input.parentElement.style.transition = 'transform 0.3s ease';
    });
    input.addEventListener('blur', () => {
      input.parentElement.style.transform = 'translateY(0)';
    });
  });

  // ---------- PARALLAX ON HERO (subtle) ----------
  const heroBg = document.querySelector('.hero-bg img');
  if (heroBg) {
    window.addEventListener('scroll', () => {
      const scrollY = window.scrollY;
      if (scrollY < window.innerHeight) {
        heroBg.style.transform = `scale(${1.05 + scrollY * 0.0002}) translateY(${scrollY * 0.15}px)`;
      }
    }, { passive: true });
  }

  // ---------- COLLECTION CARDS TILT EFFECT ----------
  if (window.innerWidth > 1024) {
    document.querySelectorAll('.collection-card').forEach(card => {
      card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        const rotateX = (y - centerY) / 20;
        const rotateY = (centerX - x) / 20;
        card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(1.02)`;
        card.style.transition = 'transform 0.1s ease';
      });
      card.addEventListener('mouseleave', () => {
        card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) scale(1)';
        card.style.transition = 'transform 0.5s ease';
      });
    });
  }

  // ---------- FAQ ACCORDION ----------
  document.querySelectorAll('.faq-question').forEach(btn => {
    btn.addEventListener('click', () => {
      const item = btn.closest('.faq-item');
      const isActive = item.classList.contains('active');
      document.querySelectorAll('.faq-item').forEach(faq => faq.classList.remove('active'));
      if (!isActive) item.classList.add('active');
    });
  });

  // ---------- ACTIVE NAV LINK HIGHLIGHTING ----------
  const sections = document.querySelectorAll('section[id]');
  if (sections.length > 0 && navLinks) {
    const sectionObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const id = entry.target.getAttribute('id');
          document.querySelectorAll('.nav-links a').forEach(link => {
            link.classList.remove('active-link');
            const href = link.getAttribute('href');
            if (href === `#${id}` || href.includes(`#${id}`)) {
              link.classList.add('active-link');
            }
          });
        }
      });
    }, { threshold: 0.3, rootMargin: '-80px 0px -50% 0px' });

    sections.forEach(section => sectionObserver.observe(section));
  }

  // ---------- IMAGE LAZY LOADING ----------
  const lazyImages = document.querySelectorAll('img[src]');
  if ('loading' in HTMLImageElement.prototype) {
    lazyImages.forEach(img => { img.loading = 'lazy'; });
  }

  // ---------- PERFORMANCE: Throttle scroll events ----------
  let ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      window.requestAnimationFrame(() => {
        handleScroll();
        ticking = false;
      });
      ticking = true;
    }
  }, { passive: true });

  // ---------- URL PARAM BUDGET PRE-SELECT ----------
  const urlParams = new URLSearchParams(window.location.search);
  const budgetParam = urlParams.get('budget');
  if (budgetParam) {
    const budgetSelect = document.getElementById('formBudget');
    if (budgetSelect) {
      for (let option of budgetSelect.options) {
        if (option.value === budgetParam) {
          option.selected = true;
          break;
        }
      }
    }
  }

});
